namespace :db do
  desc "Fill database with first 10 people"
  task populate: :environment do
  o = "Junior, II, III, Rodriguez, Wilson, Garcia, Jones, Brown, Miller, Johnson, Robinson, Adamson"
  n = "Aaron,Adam,Aidan,Alex,Alexander,Alfie,Andrew,Anthony,Archie,Bailey,Ben,Benjamin,Billy,Bradley,Brandon,Callum,Cameron,Charles,Charlie,Christopher,Connor,Corey,Daniel,David,Declan,Dominic,Dylan,Edward,Elliot,Ellis,Ethan,Ewan,Finlay,Finley,George,Harrison,Harry,Harvey,Henry,Isaac,Jacob,Jake,James,Jamie,Jay,Joe,Joel,John,Jonathan,Jordan,Joseph,Josh,Joshua,Jude,Kai,Kian,Kieran,Kyle,Leo,Leon,Lewis,Liam,Logan,Louis,Luca,Lucas,Luke,Mason,Matthew,Max,Michael,Mohammad,Mohammed,Morgan,Muhammad,Nathan,Nicholas,Noah,Oliver,Oscar,Owen,Patrick,Peter,Reece,Rhys,Robert,Ryan,Sam,Samuel,Scott,Sean,Sebastian,Spencer,Taylor,Thomas,Toby,Tom,Tyler,William"
  l = "Smith,Johnson,Williams,Jones,Brown,Davis,Miller,Wilson,Moore,Taylor,Anderson,Thomas,Jackson,White,Harris,Martin,Thompson,Garcia,Martinez,Robinson,Clark,Rodriguez,Lewis,Lee,Walker,Hall,Allen,Young,Hernandez,King,Wright,Lopez,Hill,Scott,Green,Adams,Baker,Gonzalez,Nelson,Carter,Mitchell,Perez,Roberts,Turner,Phillips,Campbell,Parker,Evans,Edwards,Collins,Stewart,Sanchez,Morris,Rogers,Reed,Cook,Morgan,Bell,Murphy,Bailey,Rivera,Cooper,Richardson,Cox,Howard,Ward,Torres,Peterson,Gray,Ramirez,James,Watson,Brooks,Kelly,Sanders,Price,Bennett,Wood,Barnes,Ross,Henderson,Coleman,Jenkins,Perry,Powell,Long,Patterson,Hughes,Flores,Washington,Butler,Simmons,Foster,Gonzales,Bryant,Alexander,Russell,Griffin,Diaz,Hayes"
  ot = o.split(', ')
  na = n.split(',')
  ln = l.split(',')
			
    4959.times do |n|
      fname  = na[rand(na.length)]
	  lname  = ln[rand(ln.length)]
	  mname  = ot[rand(ot.length)]
      email = "fake4-#{n+1}@batman.org"
	  pnum = (0..9).to_a.shuffle[0..11].join
	  dob = rand(20.years..70.years).seconds.ago
      password  = "password"
      Person.create!(firstname: fname,
					lastname: lname,
					middlename: mname,
					email: email,
					phone: pnum,
					dob: dob,
					password: password,
					password_confirmation: password)
    end
  end
end