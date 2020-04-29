# require 'pg'

require_relative 'models/user.rb'
require_relative 'models/card.rb'

arr1 = %w(jerry riley jenifer krista dubran timi alison)

family = %w(hampton garcia smith pacunia ramirez histam)

arr2 = %w(https://randomuser.me/api/portraits/women/78.jpg https://randomuser.me/api/portraits/men/61.jpg https://randomuser.me/api/portraits/women/21.jpg https://randomuser.me/api/portraits/women/41.jpg https://randomuser.me/api/portraits/men/84.jpg https://randomuser.me/api/portraits/men/72.jpg)

arr3 = %w(zendesk xero ga woolworths street kawasaki)

arr4 = %w(developer engineer chef shop-assitant rascal)

arr5 = %w(at-work at-my-friends at-school in-the-street)

arr6 = "none"

arr7 = %w(HTML CSS Javascript Ruby)

arr8 = %w(creator implementer doer tester flexor)

arr9 = "aehfoiafa pfjawfjanflanw lnnawin landlan  wajawpd d awdadawh awad adda wd awdadada  fawpfja "


# create_user('t@t.com', 321321)
user = get_user_by_email('t@t.com')

30.times do 
    create_card(
        "#{arr1.sample} #{family.sample}", arr2.sample, arr3.sample, arr4.sample, arr5.sample, arr6, arr7.sample, arr8.sample, arr9, user["id"]
    )
end

# require 'pry'
# binding.pry