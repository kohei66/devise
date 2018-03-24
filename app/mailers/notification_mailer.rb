class NotificationMailer < ApplicationMailer
  def notification_mail(blog)
    @blog = blog
    attachments["distributor.xlsx"] =
    File.read(Rails.root.join("tmp/distributor.xlsx"))
    mail(to:@blog.user.email, subject:"代理店登録承認依頼 受領連絡")
    #code
  end

end
