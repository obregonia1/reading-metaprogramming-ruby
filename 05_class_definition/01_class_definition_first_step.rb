# 1. ExClassクラスのオブジェクトが2つあります。これらをJudgement.callに渡しています。
#    Judement.callはテスト側で定義するので実装は不要です。この状況でe2オブジェクト"だけ"helloメソッドを
#    使えるようにしてください。helloメソッドの中身は何でも良いです。

class ExClass
end

e1 = ExClass.new
e2 = ExClass.new

def e2.hello; end

Judgement.call(e1, e2)

# 2. ExClassを継承したクラスを作成してください。ただし、そのクラスは定数がない無名のクラスだとします。
#    その無名クラスをそのままJudgement2.call の引数として渡してください(Judgement2.callはテスト側で定義するので実装は不要です)

klass = Class.new(ExClass) do
end
Judgement2.call(klass)

# 3. 下のMetaClassに対し、次のように`meta_`というプレフィックスが属性名に自動でつき、ゲッターの戻り値の文字列にも'meta 'が自動でつく
#    attr_accessorのようなメソッドであるmeta_attr_accessorを作ってください。セッターに文字列以外の引数がくることは考えないとします。
#
#    使用例:
#
#    class MetaClass
#      # meta_attr_accessor自体の定義は省略
#      meta_attr_accessor :hello
#    end
#    meta = MetaClass.new
#    meta.meta_hello = 'world'
#    meta.meta_hello #=> 'meta world'

class MetaClass
  @values = {}

  define_singleton_method :values do
    @values
  end

  def self.meta_attr_accessor(arg)
    define_method "meta_#{arg}"  do
      "meta #{self.class.values[arg]}"
    end

    define_method "meta_#{arg}=" do |value|
      self.class.values[arg] = value
    end
  end
end

# 4. 次のようなExConfigクラスを作成してください。ただし、グローバル変数、クラス変数は使わないものとします。
#    使用例:
#    ExConfig.config = 'hello'
#    ExConfig.config #=> 'hello'
#    ex = ExConfig.new
#    ex.config #=> 'hello'
#    ex.config = 'world'
#    ExConfig.config #=> 'world'


class ExConfig
  def config
    self.class.config
  end

  def config=(value)
    self.class.config = value
  end

  class << self
    attr_accessor :config
  end
end

# 5.
# ExOver#helloというメソッドがライブラリとして定義されているとします。ExOver#helloメソッドを実行したとき、
# helloメソッドの前にExOver#before、helloメソッドの後にExOver#afterを実行させるようにExOverを変更しましょう。
# ただしExOver#hello, ExOver#before, ExOver#afterの実装はそれぞれテスト側で定義しているので実装不要(変更不可)です。
#

class ExOver
  alias alias_hello hello

  def hello
    before
    alias_hello
    after
  end
end

# 6. 次の toplevellocal ローカル変数の中身を返す MyGreeting#say を実装してみてください。
#    ただし、下のMyGreetingは編集しないものとします。toplevellocal ローカル変数の定義の下の行から編集してください。
#    ヒント: スコープゲートを乗り越える方法について書籍にありましたね

class MyGreeting
end

toplevellocal = 'hi'

MyGreeting.class_eval do
  define_method :say do
    toplevellocal
  end
end
