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
        notes = []
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
            notes = extract_notes(doc)
            # print notes
            # sections.each_with_index do |item, i|
            #   note = Note.new
            #   note.chapter = chapters[i]
            #   note.section = sections[i]
            #   note.location = locations[i]
            #   note.content_type = types[i]
            #   note.color_type = color_types[i]
            #   note.content = contents[i]
            #   note.note = notes[i]
            #   note.user_id = current_user.id
            #   note.notebook_id = notebook.id
            #   note.save
            # end
          end
        }

        # make unread emails as read status
        # Mail.find(keys: ['NOT','SEEN']) do |email, imap, uid|
        #   imap.uid_store( uid, "+FLAGS", [Net::IMAP::SEEN] )
        # end
        {status: 200, notes: notes}
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

def escape_str(str)
  return str && str.gsub(/['>'|-]/, '').strip
end

def extract_notes(doc)
  chapters = []
  notes = []
  # debugger
  # FIXME: chapter field
  doc.css('.sectionHeading').each_with_index do |item, i|
    chapters.push item.text.strip
  end

  doc.css('.noteHeading').each_with_index do |item, i|
    data = {}
    text = item.text.strip

    no_location_text = text.split('Location ').first
    data[:location] = escape_str text.split('Location ')[1]

    no_section_text = no_location_text.split('-').first
    data[:section] = escape_str no_location_text.split('-')[1]

    type_text = no_section_text.split('(').first
    data[:type] = (escape_str type_text).downcase
    data[:color_type] = escape_str no_section_text.split('(')[1]

    data[:content] = escape_str item.next_element.text
    data[:note] = escape_str item.next_element.text
    # if data[:type] == 'note'
    #   notes[i-1][:note] && (notes[i-1][:note] = escape_str item.next_element.text)
    # else
    # end
    notes.push data
  end

  return notes
end
