require 'mail'
require 'nokogiri'
require 'open-uri'

module Yuetai
  class Notebooks < Grape::API
    resource :notebooks do
      desc 'Get all notebooks'

      get do
        if params[:user_id]
          user = User.find(params[:user_id])
          notebooks = user.notebooks.order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
        else
          notebooks = Notebook.order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
        end
        present :notebooks, notebooks, with: Entities::Notebook
        present :per_page, notebooks.per_page
        present :page, notebooks.current_page
        present :total_pages, notebooks.total_pages
        present :total_entries, notebooks.total_entries
      end

      get :import do
        authenticate!
        Mail.defaults do
          retriever_method :imap, :address    => "imap.exmail.qq.com",
                                  :port       => 993,
                                  :user_name  => 'test@larklearning.com',
                                  :password   => '111111Lark',
                                  :enable_ssl => true
        end
        unread_emails = Mail.find(keys: ['NOT','SEEN'])
        from = 'wendycaner@icloud.com'
        unread_emails_from_kindle_email = unread_emails.select{|email| email.from[0] == from}

        {status: 200, count: unread_emails_from_kindle_email.length}
      end

      put :import do
        authenticate!
        Mail.defaults do
          retriever_method :imap, :address    => "imap.exmail.qq.com",
                                  :port       => 993,
                                  :user_name  => 'test@larklearning.com',
                                  :password   => '111111Lark',
                                  :enable_ssl => true
        end
        unread_emails = Mail.find(keys: ['NOT','SEEN'])
        from = 'wendycaner@icloud.com'
        unread_emails_from_kindle_email = unread_emails.select{|email| email.from[0] == from}
        attachments = unread_emails_from_kindle_email.map {|email| email.attachments.last.body.to_s.force_encoding('utf-8')}

        # parse attachments and save to notebook
        attachments.each { |html|
          doc = Nokogiri::HTML(html)

          title = doc.at_css('.bookTitle').text.strip
          notebook = Notebook.where(title: title).first
          if notebook.nil?
            Notebook.new(title: title)
          else
            notebook.notes.each do |note|
              note.destroy!
            end
          end
          notebook.citation = doc.at_css('.citation').text.strip
          notebook.authors = doc.at_css('.authors').text.strip
          notebook.user_id = current_user.id
          if notebook.save
            chapters = []
            sections = []
            locations = []
            types = []
            color_types = []
            contents = []
            notes = []
            # FIXME: chapter field
            doc.css('.sectionHeading').each_with_index do |item, i|
              chapters.push item.text.strip
            end

            # FIXME: merge note、highlight
            doc.css('.noteHeading').each_with_index do |item, i|
              text = item.text.strip

              no_location_text = text.split('Location ').first
              locations.push text.split('Location ')[1]

              no_section_text = no_location_text.split('-').first
              sections.push no_location_text.split('-')[1]

              type_text = no_section_text.split('(').first
              types.push type_text
              color_types.push no_section_text.split('(')[1]
            end
            doc.css('.noteText').each_with_index do |item, i|
              contents.push item.text.strip
              notes.push item.text.strip
            end
            sections.each_with_index do |item, i|
              note = Note.new
              note.chapter = chapters[i]
              note.section = sections[i]
              note.location = locations[i]
              note.content_type = types[i]
              note.color_type = color_types[i]
              note.content = contents[i]
              note.note = notes[i]
              note.user_id = current_user.id
              note.notebook_id = notebook.id
              note.save
            end
          end
        }

        # make unread emails as read status
        # Mail.find(keys: ['NOT','SEEN']) do |email, imap, uid|
        #   imap.uid_store( uid, "+FLAGS", [Net::IMAP::SEEN] )
        # end
        {status: 200}
      end

      route_param :id, requirements: /[^\/]+/ do
        delete do
          authenticate!
          notebook = Notebook.find(params[:id])
          notebook.destroy!
          {status: 204}
        end
      end
    end
  end
end
