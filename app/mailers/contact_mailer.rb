class ContactMailer < ApplicationMailer
  def contact_mail(blog)
   @blog = blog
   mail(to:'k.kobayashi0606@icloud.com', subject:'代理店新規登録申請 確認メール')
  end
  end
