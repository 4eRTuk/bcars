namespace :db do
  desc "Fill database with 2k cars"
  task caralate: :environment do
  
    2412.times do |n|
	  ms = Model.pluck(:id)
      md  = Model.find(ms[rand(ms.length)])
	  m = md.id
	  sp = md.specifications.pluck(:id)
	  sc = Specification.find(sp[rand(sp.length)])
	  s  = sc.id
	  en  = sc.engines.pluck(:id)
	  eg = Engine.find(en[rand(en.length)])
	  e = eg.id
      op = md.options.pluck(:id)
	  os = Option.find(op[rand(op.length)]) if op.length > 0
	  
	  if !op.blank?
		opp = os.price
	  else
		opp = 0
	  end
	  
	  p = sc.price + opp
	  c = "#" + rand(0xffffff).to_s(16)
	  od = Time.zone.now
	   
      Car.create!(model_id: m,
				specification_id: s,
				engine_id: e,
				price: p,
				color: c)
					
		cr = Car.last
		si = rand(7)
		si+=1 if si == 1
		Order.create!(car_id: cr.id,
				client_id: 500+n*2,
				manager_id:1,
				order_date: od,
				status_id:si
				)
		
		Order.last.options << os unless os.nil?
    end
  end
end