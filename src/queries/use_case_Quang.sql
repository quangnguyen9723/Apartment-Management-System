-- add a maintenance request
INSERT INTO Maintenance (apartment_id, category, status)
VALUES (100, 'Water', 'In Progress')

-- close a maintenance request
update Maintenance
set status = 'Done'
where id = 1

-- show all unfinished requests in a building
select m.id, m.apartment_id, m.category
from Building b
    join Apartment a on b.id = a.building_id
    join Maintenance m on a.id = m.apartment_id
where b.name = 'Kuzion' and m.status = 'In Progress'