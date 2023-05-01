--(Minh)
--* Raise the house price due to inflation (Input apartment_id to be updated and new price).
--* Query x available apartments that have the lowest price.

-- Raise the price every apartment of Blossom by %5
UPDATE Apartment
SET price = price * 1.05
WHERE building_id = (SELECT id FROM Building WHERE Name = 'Kuzion')

-- 5 cheapest house
SELECT TOP 5 b.Name AS BuildingName, a.price, a.id AS ApartmentId
FROM Apartment a
JOIN Building b ON a.building_id = b.id
WHERE a.availability = 'vacant'
ORDER BY a.price ASC

