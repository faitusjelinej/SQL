create TABLE CustomerContacts (
    CustomerID INT,
    CustomerName VARCHAR(255), 
    WorkEmail VARCHAR(255),
    PersonalEmail VARCHAR(255),
    Phone VARCHAR(20)
);


INSERT INTO CustomerContacts (CustomerID, CustomerName, WorkEmail, PersonalEmail, Phone) VALUES
(1, 'John', 'john@company.com', NULL, '123-456-7890'),
(1, 'John', NULL, 'john@gmail.com', NULL),
(1, 'John', 'john.work@corp.com', 'john.alt@gmail.com', '321-654-0987'),
(2, 'Alice', 'alice@company.com', NULL, NULL),
(3, 'Bob', NULL, 'bob@gmail.com', NULL),
(3, 'Bob', 'bob@business.org', 'bob.alt@yahoo.com', '111-222-3333'),
(4, 'Charlie', NULL, NULL, '555-555-5555'),
(5, 'Daniel', NULL, 'daniel@gmail.com', '888-888-888'),
(5, 'Daniel', NULL, 'daniel@gmail.com', '555-555-5555')
;



select Customerid,
group_concat(distinct WorkEmail) as allworkemails,
group_concat(distinct PersonalEmail) as allpersonalemails,
group_concat(distinct Phone) as allPhones
FROM CustomerContacts
group by customerid
;
