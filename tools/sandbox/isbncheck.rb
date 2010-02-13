# Taken from the isbn_validation plugin.
# git://github.com/zapnap/isbn_validation.git
# http://github.com/zapnap/isbn_validation/tree/master

def validate_isbn10(isbn)
  if (isbn || '').match(/^(?:\d[\ |-]?){9}[\d|X]$/)
    isbn_values = isbn.upcase.gsub(/\ |-/, '').split('')
    check_digit = isbn_values.pop # last digit is check digit
    check_digit = (check_digit == 'X') ? 10 : check_digit.to_i
    sum = 0
    isbn_values.each_with_index do |value, index|
      sum += (index + 1) * value.to_i
    end
    (sum % 11) == check_digit
  else
    false
  end
end

def validate_isbn13(isbn)
  if (isbn || '').match(/^(?:\d[\ |-]?){13}$/)
    isbn_values = isbn.upcase.gsub(/\ |-/, '').split('')
    check_digit = isbn_values.pop.to_i # last digit is check digit
    sum = 0
    isbn_values.each_with_index do |value, index|
      multiplier = (index % 2 == 0) ? 1 : 3
      sum += multiplier * value.to_i
    end
    (10 - (sum % 10)) == check_digit
   else
    false
  end
end

def is_valid_isbn(isbn)
  if (validate_isbn10(isbn) or validate_isbn13(isbn))
    return true
  else
    return false
  end
end
