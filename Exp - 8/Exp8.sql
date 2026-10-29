CREATE TABLE bank_accounts ( account_id INT PRIMARY KEY, account_holder VARCHAR(50),
balance NUMERIC(12, 2) CHECK (balance >= 0)
);


INSERT INTO bank_accounts VALUES
(101, 'Rahul', 10000.00),
(102, 'Aman', 5000.00);


SELECT * FROM bank_accounts;

UPDATE bank_accounts
SET balance = balance - 2000 WHERE account_id = 101;
 
UPDATE bank_accounts
SET balance = balance + 2000 WHERE account_id = 102; COMMIT;
SELECT * FROM bank_accounts;

UPDATE bank_accounts
SET balance = balance - 1000 WHERE account_id = 101; SELECT * FROM bank_accounts; ROLLBACK;
SELECT * FROM bank_accounts;

BEGIN;
UPDATE bank_accounts SET balance = balance - 500 WHERE account_id = 101; SAVEPOINT sp1;
UPDATE bank_accounts
SET balance = balance - 20000 WHERE account_id = 101; ROLLBACK TO SAVEPOINT sp1;

UPDATE bank_accounts SET balance = balance + 500 WHERE account_id = 102;

COMMIT;


SELECT * FROM bank_accounts;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; START TRANSACTION;

SELECT * FROM bank_accounts;


COMMIT;


-- Session 1: BEGIN;
UPDATE bank_accounts SET balance = 9000 WHERE account_id = 101;
-- Do not commit yet.

-- Session 2:
BEGIN TRANSACTION
ISOLATION LEVEL READ COMMITTED;
SELECT balance FROM bank_accounts
WHERE account_id = 101; COMMIT;
