class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :question_with_htags
  has_many :hashtags, through: :question_with_htags

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255}

  after_commit :question_hashtags, on: :create
  after_commit :extract_htags, on: [:create, :update]
  # after_commit :question_hashtags, :answer_hashtags, on: :update

################################################
  # puts "Введите строку с хэштегами:"
  # string = STDIN.gets.chomp

  # Запишем регулярное выражение для нашего хэштега в переменную hashtag_regexp.
  # Нам нужен символ «#», за которым следует как минимум один символ слова: буква
  # русского или латинского алфавита, цифра или подчекивание. Добавим также минус.
  #
  # Подробнее о всевозможных ключевых символах в регулярных выражениях руби типа
  # [:word:] можно прочитать в документации к классу Regexp:
  #
  # https://ruby-doc.org/core-2.4.0/Regexp.html
  # hashtag_regexp = /#[[:word:]-]+/
  # /(?:^|\s)(?:(?:#\d+?)|(#\w+?))\s/
  # /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/

  # Для поиска соответствий регулярному выражению в строке используем метод строки
  # scan, который на вход принимает регулярное выражение. Каждое найденное
  # соответствие он запишет в отдельный элемент массива, который вернет.
  #
  # https://ruby-doc.org/core-2.4.0/String.html#method-i-scan
  # hashtags = string.scan(hashtag_regexp)

  # Выводим найденные хэштеги на экран
  # puts
  # puts "Нашли вот такие хэштеги: " + hashtags.join(", ")
  ###################################################

  def extract_htags
    tags = self.text.scan(/#[[:word:]-]+/)

    tags.each do |htag|
      @new_htag = hashtags.create(tag: htag)
    end
  end

  def question_hashtags
    @q_hashtags = []

    content_q = self.text.split(" ")
    content_q.map do |word|
      if word.include?("#")
        @q_hashtags << word
      end
    end
    @q_hashtags = @q_hashtags.join(" ")

    self.qhashtags = @q_hashtags
  end

  def answer_hashtags
    @a_hashtags = []

    unless answer == nil
      content_a = answer.split(" ")
      content_a.each do |word|
        if word.include?("#")
          @a_hashtags << word
        end
      end
      @a_hashtags = @a_hashtags.join(" ")

      question.ahashtags = @a_hashtags
    end
  end
end
