#A program in ruby to calculate the total price of grocery selected.


class Discountable

    def initialize(single_price, bulk_quantity, bulk_price)

      @single_price = single_price
      @bulk_quantity = bulk_quantity
      @bulk_price = bulk_price
      @bulk_discount = single_price * bulk_quantity - bulk_price
    end
  
    #method to calculating the price w/o saleprice
    def no_sale_price(quantity)
      quantity * @single_price
    end
  
    #method to calculating the price with saleprice
    def sale_price(quantity)

      sale_quantity = quantity / @bulk_quantity
      sale_discount = sale_quantity * @bulk_discount
      no_sale_price(quantity) - sale_discount
    end
  end
  
  puts 'Please enter all the items purchased separated by a comma'
  purchases = gets.split(',').map(&:strip)
  

  items = [
    ['Milk', Discountable.new(3.97, 2, 5.00), purchases.count('milk')],
    ['Bread', Discountable.new(2.17, 3, 6.00), purchases.count('bread')],
    ['Apple', Discountable.new(0.89, 1, 0.89), purchases.count('apple')],
    ['Banana', Discountable.new(0.99, 1, 0.99), purchases.count('banana')],
  ]
  

  total_sale_price = items.sum {|item, discountable, quantity| discountable.sale_price(quantity) }

  total_no_sale_price = items.sum {|item, discountable, quantity| discountable.no_sale_price(quantity) }

  total_saving = total_no_sale_price - total_sale_price
  
  puts '--------------------------------------'
  puts 'Item     Quantity      Price'
  puts '--------------------------------------'
 
  for item, discountable, quantity in items
    puts '%-8s %2d            $%.2f' % [item, quantity, discountable.sale_price(quantity)]
  end


  puts
  puts 'Total price : $%.2f' % [total_sale_price]
  puts 'You saved $%.2f today.' % [total_saving]
