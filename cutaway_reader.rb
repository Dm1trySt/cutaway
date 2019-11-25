require 'rexml/document'

# Путь до папки
current_path = File.dirname(__FILE__ )

# путь до файла
file_name = current_path + "/cutaway.xml"

# Не найден файл
abort 'Не удалось найти визитку' unless File.exist?(file_name)

# открываем файл
file = File.new(file_name, 'r:UTF-8')

# Создает новый XML объект из файла
doc = REXML::Document.new(file)

cutaway = Hash.new

# Ключами в нашем массиве будут не метки (как обычно), а строки
['name', 'middle_name','surname','phone','email','skills'].each do |item|

  cutaway[item] = doc.root.elements[item].text

end

# Закрываем файл
file.close


puts "#{cutaway['name']} #{cutaway['middle_name'][0]}. #{cutaway['surname']}"
puts "#{cutaway['phone']}, #{cutaway['email']}"
puts "#{cutaway['skills']}"
