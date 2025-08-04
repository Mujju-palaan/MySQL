-- 7)Stored Procedure for Banking Transactions

-- Develop an SQL stored procedure to process banking debit and credit transactions. 
-- The procedure should execute the following tasks: log the transaction in the transaction table, 
-- update the account balance, and document the changes in the account history. Additionally, 
-- if the transaction pertains to a credit card purchase, ensure the CARD table is updated accordingly.

DELIMITER $$

CREATE PROCEDURE scrop7_banking_transaction(
	IN p_amount DECIMAL(10,2),
	IN p_transaction_type VARCHAR(50),		-- 'debit' or 'credit'
	IN p_payment_mode VARCHAR(50),			--  ('ATM', 'cash deposit', 'loan payment', 'fund transfer', 
											-- 'debit card', 'fees', 'credit card')
	IN p_account_id INT,
	IN p_transaction_status VARCHAR(50),	-- ('processing', 'declined', 'completed')
	IN p_description VARCHAR(50)
)
BEGIN
	DECLARE d_before_balance DECIMAL(10,2);
	DECLARE d_after_balance DECIMAL(10,2);
	DECLARE d_transaction_id INT;

	-- Step 1: Insert into `transaction` table
	INSERT INTO `transaction` (
		amount, transaction_type, payment_mode, account_id, transaction_status, description
	) VALUES (
		p_amount, p_transaction_type, p_payment_mode, p_account_id, p_transaction_status, p_description
	);

	-- Step 2: Get the last inserted transaction ID
	SET d_transaction_id = LAST_INSERT_ID();

	-- Step 3: Get current balance before transaction
	SELECT balance INTO d_before_balance
	FROM account
	WHERE account_id = p_account_id;

	-- Step 4: Update the account balance
	IF p_transaction_type = 'credit' THEN
		UPDATE account
		SET balance = balance + p_amount
		WHERE account_id = p_account_id;
	ELSE
		UPDATE account
		SET balance = balance - p_amount
		WHERE account_id = p_account_id;
	END IF;

	-- Step 5: Get the balance after update
	SELECT balance INTO d_after_balance
	FROM account
	WHERE account_id = p_account_id;

	-- Step 6: Log into account_history
	INSERT INTO account_history (
		account_id, balance_before, balance_after, transaction_id
	) VALUES (
		p_account_id, d_before_balance, d_after_balance, d_transaction_id
	);

	-- Step 7: If payment is via credit card, update card table
	IF p_payment_mode = 'credit card' THEN
		UPDATE card
		SET 
			max_credit_limit = credit_limit - p_amount,
			available_credit_limit = available_credit_limit - p_amount
		WHERE account_id = p_account_id
			AND card_type = 'credit';
	END IF;

END $$
DELIMITER ;
