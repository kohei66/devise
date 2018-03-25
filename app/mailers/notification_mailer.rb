class NotificationMailer < ApplicationMailer
  def notification_mail(blog)
    @blog = blog
    mail(to:@blog.user.email, subject:"代理店登録承認依頼 受領連絡")
    #code
  end

end
