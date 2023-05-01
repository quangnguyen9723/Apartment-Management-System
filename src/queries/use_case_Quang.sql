INSERT INTO Maintenance (apartment_id, staff_id, category, status)
VALUES (1000, 1000, 'Other', 'In Progress')


update Maintenance
set status = 'Done'
where apartment_id = 1000


select m.apartment_id, m.category
from Building b
         join Apartment a on b.id = a.building_id
         join Maintenance m on a.id = m.apartment_id
where b.name = 'Kuzion'
