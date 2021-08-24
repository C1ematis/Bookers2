# README
* ログイン方法の変更
*   views/devise/sessions/new.html.erb(ログインページ)の email_field と email を適切なものに変更
*   config/initializers/devise.rb の#config.authentication_keys = [:email] を#を消し適切なものに変更
*

* アクセス制限
*   before_action :correct_user, only: [:edit, :update]
*
*         :
*         :
*
*  private
*    def correct_user
*    book = Book.find(params[:id])
*     if current_user.id != book.user.id
*      redirect_to books_path
*     end
*    end
*
* を*_controller.rb に記入。only: で制限するアクションを決める。if ~ でID が違うならリダイレクトさせる
*
* バリデーション設定
*   length: { minimum: 2, maximum: 20 } 文字数による制限
*   uniqueness: true                    一意性(重複)が無いか
*
*   add_index :users, :name, unique: true   migrate に記述[usersモデルのnameカラムの一意性の制約]
*
* サクセスメッセージ
*   redirect_to URL, notice: "表示メッセージ"  ：" " がnotice に代入されるので<%= notice %> をhtml に記入。devise によるログインは<%= notice %> のみで表示される
*
* ページ再読み込み
* redirect_back(fallback_location: PAGE_PATH)