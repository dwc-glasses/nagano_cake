module Admin::OrderInfosHelper
  def order_status_hash
    order_hash = { '0': "入金待ち", '1': "入金確認", '2':"製作中", '3':"発送準備中", '4':"発送済み" }
    return order_hash
  end

  def sales_status_hash
    sales_hash = { '0': "着手不可", '1': "製作待ち", '2':"製作中", '3':"制作完了" }
    return sales_hash
  end

  def payment_method_hash
    payment_hash = { '0': "クレジットカード", '1': "銀行振込" }
    return payment_hash
  end
end
