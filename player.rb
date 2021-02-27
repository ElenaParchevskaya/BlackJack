class Player
  NAME_FORMAT = /^[a-zа-я ]+$/i.freeze

  attr_writer :type
  attr_reader :money, :type_default

  def initialize(name, type)
    @name = name
    @money = 100
    @type_default = type
    validate!
  end

  def change_money(val)
    @money += val
    raise @name if @money < 0

    -val
  end

  def to_s
    @name
  end

  private

  def validate!
    raise "Имя слишком короткое!" if @name.length < 2
    raise "Имя некорректное, можно только буквы и пробелы" if @name !~ NAME_FORMAT
  end
end
