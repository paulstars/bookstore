

create table publishers
	(
	 publisher_id		SERIAL PRIMARY KEY, 
	 email				varchar(40), /*publisher's email*/
	 address			varchar(40), /*publisher's address*/
	 publisher_name		varchar(40) NOT NULL /*publisher's name*/
	);

create table publisher_contacts

	(
	 publisher_contact_id		SERIAL PRIMARY KEY, 
	 publisher_id				int NOT NULL, 
	 phone_number				varchar(12) NOT NULL, /*publisher's phone number*/
	 foreign key (publisher_id) references publishers (publisher_id) /*reference publisher*/
	);

create table books
	(
	 isbn						varchar(13) NOT NULL, /*book's unique identifier*/
	 book_title					varchar(50) NOT NULL, /*book's title*/
	 page_num					numeric(5,0) NOT NULL, /*book's total page number*/
	 book_price 				decimal(7,2) NOT NULL, /*book's price*/
	 inventory_count			numeric(5,0) NOT NULL, /*book's current inventory*/
	 restock_threshold			numeric(5,0) NOT NULL, /*book's restock threshold*/
	 book_genre					varchar(30) NOT NULL, /*book's genre*/
	 publisher_sale_percentage	numeric(3,2) NOT NULL, /*publishers's percent of sales*/
	 publisher_id				int NOT NULL,
	 hidden						boolean,				/*if book is visible to default users*/
	 expenditure				decimal(7,2) NOT NULL,	/*cost to create a book*/
	 primary key (isbn),
	 foreign key (publisher_id) references publishers (publisher_id)
	);

create table collections
	(
	 collection_id				SERIAL PRIMARY KEY, 
	 collection_title			varchar(50),	/*collection name*/
	 collection_description		varchar(1000)	/*collection description*/
	);

create table collection_books
	(isbn					varchar(13) NOT NULL,
	 collection_id			int NOT NULL,
	 primary key (isbn, collection_id),
	 foreign key (isbn) references books (isbn),
	 foreign key (collection_id) references collections (collection_id)
	);
	
create table bank_accounts
	(publisher_id		int NOT NULL,
	 account_balance	numeric(8,2),	/*publisher's account balance*/
	 primary key (publisher_id),
	 foreign key (publisher_id) references publishers (publisher_id)
	);

create table authors
	(author_id			SERIAL PRIMARY KEY, 
	 first_name			varchar(25) NOT NULL,	/*authors' first name*/
	 last_name			varchar(25) NOT NULL,	/*authors' last name*/
	 artist_name 		varchar(25),			
	 publisher_id		int NOT NULL,
	 foreign key (publisher_id) references publishers (publisher_id)
	);

create table book_authors
	(
	 isbn				varchar(13) NOT NULL,
	 author_id				int NOT NULL,
	 primary key (isbn, author_id),
	 foreign key (isbn) references books (isbn),
	 foreign key (author_id) references authors (author_id)
	);

create table store_orders
	(
	 store_order_id				SERIAL PRIMARY KEY, 
	 book_quantity				numeric(5,0),		/*quantity ordered*/
	 email_text					varchar(1000),		/*what would theoretically be sent in the email*/
	 isbn					varchar(13) NOT NULL,
	 publisher_id				int NOT NULL, 
	 foreign key (isbn) references books (isbn),
	 foreign key (publisher_id) references publishers (publisher_id)
	);


create table users
	(
	 username				varchar(30) NOT NULL, /*username*/
	 first_name				varchar(30) NOT NULL, /*user's first name*/
	 last_name				varchar(30) NOT NULL, /*user's last name*/
	 billing_address		varchar(60) NOT NULL, /*user's address*/
	 credit_card_num				numeric(19,0), /*user's credit card*/
	 credit_card_cvs				numeric(4,0), /*user's credit card cvs*/
	 email_address			varchar(30) NOT NULL, /*user's email*/
	 password				varchar(25) NOT NULL,  /*user's password*/
	 role					varchar(25) NOT NULL, /*owner vs default*/
	 primary key (username)
	);

create table book_checkouts
	(
	 book_checkouts_id		SERIAL PRIMARY KEY, 
	 isbn					varchar(13) NOT NULL,
	 username				varchar(30) NOT NULL,
	 foreign key (isbn) references books (isbn),
	 foreign key (username) references users (username)
	);

create table user_orders
	(
	 user_order_id					SERIAL PRIMARY KEY, 
	 preferred_billing_address		varchar(60) NOT NULL, /*user's prefered address for this order*/
	 preferred_credit_num			numeric(19,0),	/*user's prefered credit card number*/
	 preferred_credit_cvs			numeric(3,0),	/*user's prefered credit card number cvs*/
	 order_day						numeric(2,0),
	 order_month					numeric(2,0),
	 order_year						numeric(4,0),
	 total_paid 					decimal(7,2) NOT NULL, /*total paid on this order, we must keep this in case the price of a book changes after this order is created*/
	 tracking_status				varchar(25) NOT NULL, /*orders tracking status */
	 username						varchar(30) NOT NULL,
	 foreign key (username) references users (username)
	);

create table user_ordered_books
	(
	 user_ordered_book_id		SERIAL PRIMARY KEY, 
	 isbn					varchar(13) NOT NULL,
	 user_order_id					int NOT NULL,
	 foreign key (isbn) references books (isbn),
	 foreign key (user_order_id) references user_orders (user_order_id)
	);

insert into publishers (publisher_name) values ('Book Works');
insert into bank_accounts (publisher_id,account_balance) values ('1','0.0');
insert into publishers (publisher_name) values ('Butterworth-Heinemann');
insert into bank_accounts (publisher_id,account_balance) values ('2','0.0');
insert into publishers (publisher_name) values ('McGraw Hill Financial');
insert into bank_accounts (publisher_id,account_balance) values ('3','0.0');
insert into publishers (publisher_name) values ('HarperCollins');
insert into bank_accounts (publisher_id,account_balance) values ('4','0.0');
insert into publishers (publisher_name) values ('Brill Publishers');
insert into bank_accounts (publisher_id,account_balance) values ('5','0.0');
insert into publishers (publisher_name) values ('Flame Tree Publishing');
insert into bank_accounts (publisher_id,account_balance) values ('6','0.0');
insert into publishers (publisher_name) values ('Book Works');
insert into bank_accounts (publisher_id,account_balance) values ('7','0.0');
insert into publishers (publisher_name) values ('Elloras Cave');
insert into bank_accounts (publisher_id,account_balance) values ('8','0.0');
insert into publishers (publisher_name) values ('D. Appleton & Company');
insert into bank_accounts (publisher_id,account_balance) values ('9','0.0');
insert into publishers (publisher_name) values ('Manchester University Press');
insert into bank_accounts (publisher_id,account_balance) values ('10','0.0');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-4280-9220-X','Wildfire at Midnight', '100', '3.99','11','10','Mythology','0.05','1', 'false','2.05');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-07-340569-9','The Torment of Others', '100', '4.99','25','10','Tall tale','0.05','1', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-7240-6702-7','Terrible Swift Sword', '100', '2.99','25','10','Humor','0.05','8', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-275-95272-0','Behold the Man', '100', '2.99','25','10','Fiction narrative','0.05','2', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-301-82638-2','In a Dry Season', '100', '12.99','25','10','Mystery','0.05','7', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-00-731565-1','Tender Is the Night', '100', '11.99','25','10','Historical fiction','0.05','3', 'false','6.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-5488-4521-3','Blue Remembered Earth', '100', '4.99','25','10','Fiction narrative','0.05','6', 'false','3.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-19-030130-9','The Line of Beauty', '100', '8.99','25','10','Suspense/Thriller','0.05','8', 'false','3.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-83437-018-3','Recalled to Life', '100', '2.99','25','10','Fantasy','0.05','8', 'false','1.50');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-210-71005-5','Nine Coaches Waiting', '100', '2.99','25','10','Crime/Detective','0.05','8', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-10-975457-3','The Green Bay Tree', '100', '1.99','25','10','Western','0.05','8', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-88169-027-9','Recalled to Life', '100', '2.99','25','10','Mythology','0.05','2', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-7970-2651-7','Little Hands Clapping', '100', '8.99','25','10','Speech','0.05','5', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-59729-070-X','The Cricket on the Hearth', '100', '9.99','25','10','Humor','0.05','7', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-232-85379-8','Antic Hay', '100', '2.99','25','10','Science fiction','0.05','5', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-8215-4495-0','The Lathe of Heaven', '100', '11.99','25','10','Textbook','0.05','9', 'false','10.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-272-66645-9','Jacob Have I Loved', '100', '13.99','25','10','Mythology','0.05','2', 'false','3.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-06-747899-9','For a Breath I Tarry', '100', '14.99','25','10','Short story','0.05','3', 'false','7.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-255-90383-9','The Mermaids Singing', '100', '17.99','25','10','Horror','0.05','7', 'false','10.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-09-721973-8','Carrion Comfort', '100', '22.99','25','10','Legend','0.05','6', 'false','10.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-76719-553-2','A Catskill Eagle', '100', '21.99','25','10','Legend','0.05','8', 'false','5.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-15-031562-7','Number the Stars', '100', '25.99','25','10','Humor','0.05','7', 'false','15.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-946295-14-X','Blue Remembered Earth', '100', '12.99','25','10','Fantasy','0.05','8', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-77499-258-2','Whats Become of Waring', '100', '32.99','25','10','Narrative nonfiction','0.05','5', 'false','10.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-340-00569-6','The Heart Is Deceitful Above All Things', '100', '2.99','25','10','Classic','0.05','8', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-633-52285-6','The Yellow Meads of Asphodel', '100', '7.99','25','10','Mythopoeia','0.05','6', 'false','5.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-159-68421-9','Oh! To be in England', '100', '1.99','25','10','Classic','0.05','2', 'false','0.50');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-272-71501-8','If I Forget Thee Jerusalem', '100', '3.99','25','10','Fiction narrative','0.05','5', 'false','2.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-4743-6623-6','The Soldiers Art', '100', '4.99','25','10','Realistic fiction','0.05','6', 'false','2.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-352-59863-8','Taming a Sea Horse', '100', '8.99','25','10','Short story','0.05','2', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-5184-7112-9','Such, Such Were the Joys', '100', '2.99','25','10','Comic/Graphic Novel','0.05','6', 'false','1.70');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-69347-110-8','Antic Hay', '100', '2.99','25','10','Reference book','0.05','1', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-365-68840-2','Absalom, Absalom!', '100', '6.99','25','10','Realistic fiction','0.05','2', 'false','3.0');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-963582-93-4','Far From the Madding Crowd', '100', '2.99','25','10','Classic','0.05','4', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-112-45087-4','I Know Why the Caged Bird Sings', '100', '2.99','25','10','Legend','0.05','4', 'false','1.50');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-5467-3021-4','A Catskill Eagle', '100', '7.99','25','10','Speech','0.05','6', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-11-473562-X','This Side of Paradise', '100', '2.99','25','10','Tall tale','0.05','2', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-215-19546-X','In Death Ground', '100', '8.99','25','10','Fairy tale','0.05','9', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-879384-48-5','The Doors of Perception', '100', '2.99','25','10','Fantasy','0.05','7', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-08-159405-5','To Say Nothing of the Dog', '100', '2.99','25','10','Humor','0.05','4', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-62090-151-X','I Sing the Body Electric', '100', '2.99','25','10','Legend','0.05','1', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-86040-708-X','Mr Standfast', '100', '3.99','25','10','Suspense/Thriller','0.05','6', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-06-163520-1','Clouds of Witness', '100', '4.99','25','10','Folklore','0.05','6', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-4206-3669-3','The Heart Is Deceitful Above All Things', '100', '2.99','25','10','Comic/Graphic Novel','0.05','9', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-4708-2115-X','The Golden Bowl', '100', '5.99','25','10','Fanfiction','0.05','8', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-80395-095-1','Look Homeward, Angel', '100', '4.99','25','10','Classic','0.05','4', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-251-74983-6','Recalled to Life', '100', '6.99','25','10','Humor','0.05','9', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-7679-1737-5','To Your Scattered Bodies Go', '100', '9.99','25','10','Realistic fiction','0.05','9', 'false','4.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('1-354-15493-2','For Whom the Bell Tolls', '100', '2.99','25','10','Fiction narrative','0.05','7', 'false','1.00');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('0-15-343991-2','The Proper Study', '100', '10.99','25','10','Short story','0.05','7', 'false','3.00');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Floyd','Stracke', 'Monet','7');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Patsy','Koss', 'Degas','3');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Reyes','Feil', 'Klimt','6');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Rebbecca','Steuber', 'Raphael','8');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Flavia','Grady', 'Gauguin','7');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Sallie','Fay', 'Klimt','3');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Hallie','Rodriguez', 'Paul Klee','5');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Junita','Schmeler', 'Pollock','1');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Penni','Satterfield', 'Pissarro','7');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Paris','Shields', 'Gauguin','2');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Cornell','Walsh', 'Klimt','8');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Jasmin','Jaskolski', 'Cassatt','7');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Dillon','Bayer', 'Ansel Adams','7');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Lindsay','Herzog', 'Vettriano','6');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Olen','Bogan', 'Paul Klee','3');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Benton','Spinka', 'Winslow Homer','8');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Mikaela','Botsford', 'Raphael','9');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Kerstin','Predovic', 'Rembrandt','1');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Carl','Denesik', 'Pollock','5');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Collen','Hahn', 'Vettriano','9');
insert into book_authors (isbn, author_id) values ('1-4280-9220-X','7');
insert into book_authors (isbn, author_id) values ('1-4280-9220-X','18');
insert into book_authors (isbn, author_id) values ('1-07-340569-9','1');
insert into book_authors (isbn, author_id) values ('1-07-340569-9','12');
insert into book_authors (isbn, author_id) values ('0-7240-6702-7','3');
insert into book_authors (isbn, author_id) values ('0-7240-6702-7','17');
insert into book_authors (isbn, author_id) values ('1-275-95272-0','9');
insert into book_authors (isbn, author_id) values ('1-275-95272-0','16');
insert into book_authors (isbn, author_id) values ('0-301-82638-2','6');
insert into book_authors (isbn, author_id) values ('0-301-82638-2','16');
insert into book_authors (isbn, author_id) values ('0-00-731565-1','7');
insert into book_authors (isbn, author_id) values ('0-00-731565-1','13');
insert into book_authors (isbn, author_id) values ('1-5488-4521-3','7');
insert into book_authors (isbn, author_id) values ('1-5488-4521-3','16');
insert into book_authors (isbn, author_id) values ('0-19-030130-9','8');
insert into book_authors (isbn, author_id) values ('0-19-030130-9','13');
insert into book_authors (isbn, author_id) values ('1-83437-018-3','4');
insert into book_authors (isbn, author_id) values ('1-83437-018-3','13');
insert into book_authors (isbn, author_id) values ('0-210-71005-5','8');
insert into book_authors (isbn, author_id) values ('0-210-71005-5','12');
insert into book_authors (isbn, author_id) values ('0-10-975457-3','1');
insert into book_authors (isbn, author_id) values ('0-10-975457-3','13');
insert into book_authors (isbn, author_id) values ('0-88169-027-9','5');
insert into book_authors (isbn, author_id) values ('0-88169-027-9','18');
insert into book_authors (isbn, author_id) values ('0-7970-2651-7','5');
insert into book_authors (isbn, author_id) values ('0-7970-2651-7','18');
insert into book_authors (isbn, author_id) values ('1-59729-070-X','9');
insert into book_authors (isbn, author_id) values ('1-59729-070-X','13');
insert into book_authors (isbn, author_id) values ('1-232-85379-8','6');
insert into book_authors (isbn, author_id) values ('1-232-85379-8','14');
insert into book_authors (isbn, author_id) values ('0-8215-4495-0','7');
insert into book_authors (isbn, author_id) values ('0-8215-4495-0','17');
insert into book_authors (isbn, author_id) values ('0-272-66645-9','3');
insert into book_authors (isbn, author_id) values ('0-272-66645-9','13');
insert into book_authors (isbn, author_id) values ('0-06-747899-9','8');
insert into book_authors (isbn, author_id) values ('0-06-747899-9','12');
insert into book_authors (isbn, author_id) values ('0-255-90383-9','8');
insert into book_authors (isbn, author_id) values ('0-255-90383-9','14');
insert into book_authors (isbn, author_id) values ('0-09-721973-8','8');
insert into book_authors (isbn, author_id) values ('0-09-721973-8','17');
insert into book_authors (isbn, author_id) values ('1-76719-553-2','5');
insert into book_authors (isbn, author_id) values ('1-76719-553-2','12');
insert into book_authors (isbn, author_id) values ('0-15-031562-7','3');
insert into book_authors (isbn, author_id) values ('0-15-031562-7','15');
insert into book_authors (isbn, author_id) values ('0-946295-14-X','1');
insert into book_authors (isbn, author_id) values ('0-946295-14-X','12');
insert into book_authors (isbn, author_id) values ('1-77499-258-2','5');
insert into book_authors (isbn, author_id) values ('1-77499-258-2','18');
insert into book_authors (isbn, author_id) values ('0-340-00569-6','7');
insert into book_authors (isbn, author_id) values ('0-340-00569-6','14');
insert into book_authors (isbn, author_id) values ('0-633-52285-6','5');
insert into book_authors (isbn, author_id) values ('0-633-52285-6','14');
insert into book_authors (isbn, author_id) values ('1-159-68421-9','4');
insert into book_authors (isbn, author_id) values ('1-159-68421-9','11');
insert into book_authors (isbn, author_id) values ('0-272-71501-8','4');
insert into book_authors (isbn, author_id) values ('0-272-71501-8','18');
insert into book_authors (isbn, author_id) values ('1-4743-6623-6','5');
insert into book_authors (isbn, author_id) values ('1-4743-6623-6','15');
insert into book_authors (isbn, author_id) values ('0-352-59863-8','7');
insert into book_authors (isbn, author_id) values ('0-352-59863-8','15');
insert into book_authors (isbn, author_id) values ('1-5184-7112-9','4');
insert into book_authors (isbn, author_id) values ('1-5184-7112-9','13');
insert into book_authors (isbn, author_id) values ('1-69347-110-8','7');
insert into book_authors (isbn, author_id) values ('1-69347-110-8','14');
insert into book_authors (isbn, author_id) values ('1-365-68840-2','5');
insert into book_authors (isbn, author_id) values ('1-365-68840-2','16');
insert into book_authors (isbn, author_id) values ('1-963582-93-4','5');
insert into book_authors (isbn, author_id) values ('1-963582-93-4','16');
insert into book_authors (isbn, author_id) values ('1-112-45087-4','5');
insert into book_authors (isbn, author_id) values ('1-112-45087-4','12');
insert into book_authors (isbn, author_id) values ('1-5467-3021-4','5');
insert into book_authors (isbn, author_id) values ('1-5467-3021-4','18');
insert into book_authors (isbn, author_id) values ('0-11-473562-X','5');
insert into book_authors (isbn, author_id) values ('0-11-473562-X','19');
insert into book_authors (isbn, author_id) values ('1-215-19546-X','5');
insert into book_authors (isbn, author_id) values ('1-215-19546-X','17');
insert into book_authors (isbn, author_id) values ('1-879384-48-5','3');
insert into book_authors (isbn, author_id) values ('1-879384-48-5','13');
insert into book_authors (isbn, author_id) values ('1-08-159405-5','4');
insert into book_authors (isbn, author_id) values ('1-08-159405-5','12');
insert into book_authors (isbn, author_id) values ('1-62090-151-X','1');
insert into book_authors (isbn, author_id) values ('1-62090-151-X','14');
insert into book_authors (isbn, author_id) values ('0-86040-708-X','8');
insert into book_authors (isbn, author_id) values ('0-86040-708-X','17');
insert into book_authors (isbn, author_id) values ('1-06-163520-1','5');
insert into book_authors (isbn, author_id) values ('1-06-163520-1','11');
insert into book_authors (isbn, author_id) values ('1-4206-3669-3','3');
insert into book_authors (isbn, author_id) values ('1-4206-3669-3','13');
insert into book_authors (isbn, author_id) values ('1-4708-2115-X','7');
insert into book_authors (isbn, author_id) values ('1-4708-2115-X','11');
insert into book_authors (isbn, author_id) values ('1-80395-095-1','8');
insert into book_authors (isbn, author_id) values ('1-80395-095-1','16');
insert into book_authors (isbn, author_id) values ('1-251-74983-6','2');
insert into book_authors (isbn, author_id) values ('1-251-74983-6','13');
insert into book_authors (isbn, author_id) values ('0-7679-1737-5','6');
insert into book_authors (isbn, author_id) values ('0-7679-1737-5','15');
insert into book_authors (isbn, author_id) values ('1-354-15493-2','6');
insert into book_authors (isbn, author_id) values ('1-354-15493-2','15');
insert into book_authors (isbn, author_id) values ('0-15-343991-2','9');
insert into book_authors (isbn, author_id) values ('0-15-343991-2','18');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('cecila17','Floyd','Stracke','454 Runolfsson Freeway, Port Richie, VT 67292-9884','345308474382158','940','FloydStracke@email.com','WbWvAw5PiV51gXrJbCm0','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('javier79','Patsy','Koss','Apt. 892 13756 Robt Extensions, South Mickie, TN 00699-4747','503852927717','960','PatsyKoss@email.com','W3x3Yg52PoD74iIj','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('jordan66','Reyes','Feil','Suite 412 12671 Rau Highway, Aileentown, GA 79601','566460447709','0836','ReyesFeil@email.com','TfXsNnF9gMc4','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('katheryn21','Rebbecca','Steuber','51979 Conroy Harbor, South Shon, AZ 08442','3510422794133317','693','RebbeccaSteuber@email.com','H7aAy74B0a','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('hobert27','Flavia','Grady','Suite 389 67793 Ha Forks, Merlinburgh, PA 32978','2253681324173597','038','FlaviaGrady@email.com','EkCcDhBt63Uu','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('niesha77','Sallie','Fay','Apt. 907 1256 Hilton View, South Jacinto, LA 36760-9825','4442860987395','133','SallieFay@email.com','8Cx5UnFlQd8Dq0G4141','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('darryl10','Hallie','Rodriguez','94774 Schaden Union, Lake Hoseaview, VT 37428-0675','3521994157874866','983','HallieRodriguez@email.com','1VdQ5cQrF4sJ','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('junior84','Junita','Schmeler','685 Clarence Mountains, Sydneybury, WA 54455-2515','4592146834132182','894','JunitaSchmeler@email.com','Lz4LwApH9qH56uY1xO','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('alverta67','Penni','Satterfield','Suite 670 83665 Larkin Vista, MacGyverberg, CT 37297','4803654285559097','221','PenniSatterfield@email.com','59Rl6Fq1DkDbZz6Bk','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('deedra95','Paris','Shields','90348 Lockman Trafficway, Lake Giovanni, NY 05052','6519022533329251','136','ParisShields@email.com','91KuGhUkQaLd','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('marleen77','Cornell','Walsh','560 Jed Mews, Carterburgh, NM 58111-6023','4265735251200815','748','CornellWalsh@email.com','X0a0Ba8CuQxUcRx7YwW','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('chase_be95','Jasmin','Jaskolski','Suite 151 568 Antonetta Mission, Beahanchester, CA 79430','3576449422666823','442','JasminJaskolski@email.com','ZrKw0CeSnUwHn','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('whitley20','Dillon','Bayer','Apt. 901 62984 Shanahan Burg, East Lonniemouth, OR 88530','341986770385159','2417','DillonBayer@email.com','SuK6qRxM3mAxU','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('ashely27','Lindsay','Herzog','86468 Ferdinand Locks, Brunildaborough, NH 35761-1244','4989586015036838','547','LindsayHerzog@email.com','80N7oAmXhWl','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('warner10','Olen','Bogan','Suite 336 5226 Bula Bypass, Remaburgh, SD 65422-2969','378149362070699','2594','OlenBogan@email.com','7Xm67JcMqBaY1n8OcRt','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('letisha94','Benton','Spinka','76809 Lan Lake, Schroederstad, MT 80659','30490786155421','743','BentonSpinka@email.com','94Ow9H6gLd1D8sT','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('stefan40','Mikaela','Botsford','674 Parker Street, East Jeanice, NM 34383-7111','4484623131123685','422','MikaelaBotsford@email.com','RxZ6kCnVsJ3052','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('torri.ro71','Kerstin','Predovic','7874 Joaquin Shores, Rosariobury, ME 52831-9891','3515055080117068','743','KerstinPredovic@email.com','Y4iBtMcV875p9R','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('sydney71','Carl','Denesik','359 Erline Meadow, Port Michaeleport, NY 66226-7283','3503077591758747','478','CarlDenesik@email.com','TxWmChDfRnPeQbNkYu','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('rodney83','Collen','Hahn','Suite 210 1303 Fahey Cliff, Baumbachchester, IA 59993','180084950890976','426','CollenHahn@email.com','Y2wT59gMe35QhAiJd','default');
insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('owner','Matt','MB','doing my homework street','180084950890976','426','CollenHahn@email.com','1234','admin');
