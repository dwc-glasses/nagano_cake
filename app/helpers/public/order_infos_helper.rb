module Public::OrderInfosHelper
  def order_status_hash
    order_hash = { '0': "入金待ち", '1': "入金確認", '2':"製作中", '3':"発送準備中", '4':"発送済み" }
    return order_hash
  end
  
  def payment_method_hash
    payment_hash = { '0': "クレジットカード", '1': "銀行振込" }
    return payment_hash
  end
end
