select m.apartment_id, m.category
from Building b
join Apartment a on b.id = a.building_id
join Maintenance m on a.id = m.apartment_id
where b.name = 'Kuzion'


-- select * from Building


