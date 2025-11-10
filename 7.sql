CREATE TABLE Suppliers (
    sid INT PRIMARY KEY,
    sname VARCHAR(50) NOT NULL,
    city VARCHAR(50)
);
CREATE TABLE Parts (
    pid INT PRIMARY KEY,
    pname VARCHAR(50) NOT NULL,
    color VARCHAR(20)
);
CREATE TABLE Catalog (
    sid INT,
    pid INT,
    cost DECIMAL(10, 2),
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES Suppliers(sid),
    FOREIGN KEY (pid) REFERENCES Parts(pid)
);
INSERT INTO Suppliers (sid, sname, city) VALUES
(10001, 'Acme Widget', 'Bangalore'),
(10002, 'Johns', 'Kolkata'),
(10003, 'Vimal', 'Mumbai'),
(10004, 'Reliance', 'Delhi');

INSERT INTO Parts (pid, pname, color) VALUES
(20001, 'Book', 'Red'),
(20002, 'Pen', 'Red'),
(20003, 'Pencil', 'Green'),
(20004, 'Mobile', 'Green'),
(20005, 'Charger', 'Black');

INSERT INTO Catalog (sid, pid, cost) VALUES
(10001, 20001, 10),
(10001, 20002, 10),
(10001, 20003, 30),
(10001, 20004, 10),
(10001, 20005, 10),
(10002, 20001, 10),
(10002, 20002, 20),
(10003, 20003, 30),
(10004, 20003, 40);

SELECT DISTINCT
    T2.pname
FROM
    Catalog T1
INNER JOIN
    Parts T2 ON T1.pid = T2.pid;
    
    SELECT
    S.sname
FROM
    Suppliers S
JOIN
    Catalog C ON S.sid = C.sid
GROUP BY
    S.sid, S.sname
HAVING
    COUNT(DISTINCT C.pid) = (
        SELECT COUNT(pid) FROM Parts
    );
    
    
    SELECT
    S.sname
FROM
    Suppliers S
JOIN
    Catalog C ON S.sid = C.sid
JOIN
    Parts P ON C.pid = P.pid
WHERE
    P.color = 'Red'
GROUP BY
    S.sid, S.sname
HAVING
    COUNT(DISTINCT C.pid) = (
        SELECT COUNT(pid) FROM Parts WHERE color = 'Red'
    );