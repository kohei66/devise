class ExcelMailer < ApplicationMailer
  def excel_mail(blog)
    @blog = blog
    attachments["distributor.xlsx"] =
    File.read(Rails.root.join("tmp/distributor.xlsx"))
    mail(to:@blog.email, subject:"DistributorList excel出力メール")
  end
end
