require 'rexml/document'

# Путь до папки
current_path = File.dirname(__FILE__ )

# путь до файла
xml_path = current_path + "/cutaway.xml"

# Не найден файл
abort 'Не удалось найти визитку' unless File.exist?(xml_path)

# открываем файл
xml_file = File.new(xml_path, 'r:UTF-8')

# Создает новый XML объект из файла
xml_doc = REXML::Document.new(xml_file)

# Закрываем файл
xml_file.close

cutaway = Hash.new

# Ключами в нашем массиве будут не метки (как обычно), а строки
['photo', 'name', 'middle_name','surname','phone','email','skills'].each do |item|

  # Присваеваем значения в хэш массив
  cutaway[item] = xml_doc.root.elements[item].text

end

# Создаем xml структуру
html_doc = REXML::Document.new

# Прописываем в теге html русский язык
html_doc.add_element('html',{'lang' => 'ru'})

# Кодировка
html_doc.root.add_element('head').add_element('meta', 'charset' => 'UTF-8')

# Заголовок
html_doc.root.add_element('title').add_text("Визитная карточка")

# Тело
body = html_doc.root.add_element('body')

# Добавляем в тело фото
body.add_element('p').add_element('img', 'src' => cutaway['photo'], 'width' => '250', 'height' => '200')

# Добавляем заголовок (ФИО)
body.add_element('h1').add_text(
    "#{cutaway['name']} #{cutaway['middle_name'][0]}. #{cutaway['surname']}"
)

# Навыки
body.add_element('p').add_text(cutaway['skills'])

# Телефон
body.add_element('p').add_text("Телефон: #{cutaway['phone']}")

# Почта
body.add_element('p').add_text("E-mail: #{cutaway['email']}")

# Запись файла.
# Открываем файл для записи
html_file = File.new(current_path + '/cutaway.html', 'w:UTF-8')

# Это строка нужна для браузера (чтобы он понял, что это за HTML-документ)
html_file.puts('<!DOCTYPE HTML>')

# Запись html-структуры в файл
html_doc.write(html_file, 2)

# Закрываем файл
html_file.close









#puts "#{cutaway['photo']}"
#puts "#{cutaway['name']} #{cutaway['middle_name'][0]}. #{cutaway['surname']}"
#puts "#{cutaway['phone']}, #{cutaway['email']}"
#puts "#{cutaway['skills']}"

