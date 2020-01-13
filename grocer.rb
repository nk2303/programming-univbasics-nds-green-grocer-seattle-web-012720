def find_item_by_name_in_collection(name, collection)
  collection.length.times do |item|
    if collection[item][:item] == name
      return collection[item]
    end
  end
  return nil
end

def consolidate_cart(cart)
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing. [{:i=>"name", :p=>2},{},{}]
  con_cart = []
  cart.length.times do |hash|
    has_found = false
    con_cart.length.times do |check|
      if con_cart[check][:item] == cart[hash][:item]
        con_cart[check][:count] += 1
        has_found = true
      end
    end
    if(!has_found)
      new_item = cart[hash].clone
      new_item[:count] = 1
      con_cart.push(new_item)
    end
  end
  return con_cart
end

def apply_coupons(cart, coupons)
  # REMEMBER: This method **should** update cart
  if coupons.length > 0
    coupons.length.times do |c|
      cart.length.times do |item|
        if coupons[c][:item] == cart[item][:item]# && coupons[0][:num] >= cart[item][:count]
          coupon_item = cart[item].clone
          coupon_item[:item] += " W/COUPON"
          coupon_item[:price] = coupons[c][:cost] / coupons[c][:num]
          cart_count = cart[item][:count] % coupons[0][:num]
          coupon_item[:count] = cart[item][:count] - cart_count
          cart[item][:count] = cart_count
          cart.push(coupon_item)
        end
      end
    end
  end
  return cart
end

def apply_clearance(cart)
  # REMEMBER: This method **should** update cart
  cart.length.times do |hash|
    if cart[hash][:clearance]
      cart[hash][:price] = cart[hash][:price] - cart[hash][:price]*2/10
    end
  end
  return cart
end

def checkout(cart, coupons)
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
end
