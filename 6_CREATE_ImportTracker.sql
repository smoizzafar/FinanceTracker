CREATE TABLE ImportTracker (
    LockedID INT 
    PRIMARY KEY
    CONSTRAINT ImportTracker_LockedID CHECK (LockedID = 1),
    LastImportID INT
)

--initiate the tracking table
INSERT INTO ImportTracker
VALUES (1, 0)