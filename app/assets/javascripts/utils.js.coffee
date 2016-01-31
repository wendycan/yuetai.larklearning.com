window.formatNumberByTenThousand = (number)->
  if !$.isNumeric(number)
    return null
  if number < 10000 then return number
  else
    number = parseInt(number, 10) # Convert number to decimal
    strNumber = number + ''
    integer = parseInt(number/10000, 10)
    declimal = strNumber.substr(-4, 2)
    if strNumber.substr(-2, 1) >= 5 then ++declimal
    if declimal == 0
      integer + '万'
    else if declimal[1] == 0
      integer + '.' + declimal[0] + '万'
    else
      integer + '.' + declimal + '万'
