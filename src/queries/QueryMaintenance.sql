select m.apartment_id, m.category from Building b
where b.id = ?
left join Apartment a on b.id = a.building_id
left join Maintenance m on a.id = m.apartment_id



