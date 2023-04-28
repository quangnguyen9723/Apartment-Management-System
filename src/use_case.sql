--(Minh)
--* Raise the house price due to inflation (Input apartment_id to be updated and new price).
--* Query x available apartments that have the lowest price.

-- Raise the price every apartment of Blossom by %5
UPDATE Apartment
SET price = price * 1.05
WHERE building_id = (SELECT id FROM Building WHERE Name = 'Blossom')

-- 5 most expensive house
SELECT TOP 5 b.Name
FROM Apartment a
JOIN Building b ON a.building_id = b.id
ORDER BY a.price ASC
