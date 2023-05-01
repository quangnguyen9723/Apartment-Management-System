insert into Maintenance values (?, ?, ?)

update Maintenance set status = ? where apartment_id = ?

select m.apartment_id, m.category
from Building b
         join Apartment a on b.id = a.building_id
         join Maintenance m on a.id = m.apartment_id
where b.name = 'Kuzion'
