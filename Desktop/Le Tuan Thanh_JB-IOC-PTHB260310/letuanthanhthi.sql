create table customer (
    customer_id serial primary key,
    customer_full_name varchar(255) not null,
    customer_email varchar(255) not null,
    customer_phone varchar(20) not null,
    customer_address varchar(255) not null
);

create table room (
    room_id serial primary key,
    room_type varchar(50) not null,
    room_price numeric(10, 2) not null,
    room_status varchar(20) not null,
    room_area numeric(10, 2) not null
);

create table booking (
    booking_id serial primary key,
    customer_id int not null,
    room_id int not null,
    check_in_date date not null,
    check_out_date date not null,
    total_amount numeric(10, 2) not null,
    foreign key (customer_id) references customer(customer_id),
    foreign key (room_id) references room(room_id)
);

create table payment (
    payment_id serial primary key,
    booking_id int not null,
    payment_method varchar(50) not null,
    payment_amount numeric(10, 2) not null,
    payment_date date not null,
    foreign key (booking_id) references booking(booking_id)
);

insert into customer (customer_full_name, customer_email, customer_phone, customer_address) values
('Nguyen Anh Tu', 'tu.nguyen@example.com', '0901234567', 'Hanoi, Vietnam'),
('Tran Thi Mai', 'mai.tran@example.com', '0912345678', 'Ho Chi Minh, Vietnam'),
('Le Minh Hoang', 'hoang.le@example.com', '0923456789', 'Danang, Vietnam'),
('Pham Hoang nam', 'nam.pham@example.com', '0934567890', 'Hue, Vietnam'),
('Vu Minh Thu', 'thu.vu@example.com', '0956789012', 'Hai Phong, Vietnam');

insert into room (room_type, room_price, room_status, room_area) values
('Single', 100.0, 'Available', 25),
('Double', 150.0, 'Booked', 40),
('Suite', 250.0, 'Available', 60),
('Single', 120.0, 'Booked', 30),
('Double', 160.0, 'Available', 35);

insert into booking (customer_id, room_id, check_in_date, check_out_date, total_amount) values
(1, 1, '2025-03-01', '2025-03-05', 400.0),
(2, 2, '2025-03-02', '2025-03-06', 600.0),
(3, 3, '2025-03-03', '2025-03-07', 1000.0),
(4, 4, '2025-03-04', '2025-03-08', 480.0),
(5, 5, '2025-03-04', '2025-03-09', 800.0);


insert into payment (booking_id, payment_method, payment_amount, payment_date) values
(1, 'Credit Card', 400.0, '2025-03-01'),
(2, 'Cash', 600.0, '2025-03-02'),
(3, 'Bank Transfer', 1000.0, '2025-03-03'),
(4, 'Credit Card', 480.0, '2025-03-04'),
(5, 'Cash', 800.0, '2025-03-05');

--Cập nhật dữ liệu (6 điểm) Viết câu lệnh UPDATE để cập nhật lại total_amount trong bảng Booking theo công thức: total_amount = room_price * (số ngày lưu trú).
--• Điều kiện:
--◦ Chỉ cập nhật cho các phòng có trạng thái ( room_status ) là "Booked".
--◦ Chỉ cập nhật khi ngày nhận phòng ( check_in_date ) đã qua (ví dụ: check_in_date
--< CURRENT_DATE ).
UPDATE booking
SET total_amount = room.room_price * (booking.check_out_date - booking.check_in_date)
FROM room
WHERE booking.room_id = room.room_id
  AND room.room_status = 'Booked'
  AND booking.check_in_date < CURRENT_DATE;

--Xóa dữ liệu (6 điểm) Viết câu lệnh DELETE để xóa các thanh toán trong bảng Payment
--nếu:
--◦ Phương thức thanh toán ( payment_method ) là "Cash".
--◦ Và tổng tiền thanh toán ( payment_amount ) nhỏ hơn 500.
DELETE FROM payment
WHERE payment_method = 'Cash'
  AND payment_amount < 500;

-- Lấy thông tin khách hàng gồm mã khách hàng, họ tên, email, số điện thoại và địa
--chỉ được sắp xếp theo họ tên khách hàng tăng dần.
SELECT customer_id, customer_full_name, customer_email, customer_phone, customer_address
FROM customer
ORDER BY customer_full_name ASC;

--ấy thông tin các phòng khách sạn gồm mã phòng, loại phòng, giá phòng và diện
--tích phòng, sắp xếp theo giá phòng giảm dần.
select room_id, room_type, room_price, room_area
from room
order by room_area desc;

--Lấy thông tin khách hàng và phòng khách sạn đã đặt, gồm mã khách hàng, họ tên
--khách hàng, mã phòng, ngày nhận phòng và ngày trả phòng
SELECT c.customer_id, c.customer_full_name, p.payment_method, p.payment_amount
FROM customer c 
JOIN booking b ON c.customer_id = b.customer_id 
JOIN payment p ON b.booking_id = p.booking_id
ORDER BY p.payment_amount DESC;     

--Lấy thông tin khách hàng và phòng khách sạn đã đặt, gồm mã khách hàng, họ tên khách hàng, mã phòng, ngày nhận phòng và ngày trả phòng.--
SELECT c.customer_full_name, b.room_id, b.check_in_date, b.check_out_date
FROM customer c 
JOIN booking b ON c.customer_id = b.customer_id;

--Lấy danh sách khách hàng và tổng tiền đã thanh toán khi đặt phòng, gồm mã khách hàng, họ tên khách hàng,
-- phương thức thanh toán và số tiền thanh toán, sắp xếp theo số tiền thanh toán giảm dần.--
SELECT c.customer_id, c.customer_full_name, p.payment_method, p.payment_amount
FROM customer c
JOIN booking b ON c.customer_id = b.customer_id
JOIN payment p ON b.booking_id = p.booking_id
ORDER BY p.payment_amount DESC;

--Lấy thông tin khách hàng từ vị trí thứ 2 đến thứ 4 trong bảng Customer được sắp xếp theo tên khách hàng.
SELECT customer_id, customer_full_name, customer_email, customer_phone, customer_address
FROM customer
ORDER BY customer_full_name ASC
OFFSET 1 LIMIT 3;

--. (5 điểm) Lấy danh sách khách hàng đã đặt ít nhất 2 phòng và có tổng số tiền thanh toá trên 1000,
-- gồm mã khách hàng, họ tên khách hàng và số lượng phòng đã đặt.--  
SELECT c.customer_id, c.customer_full_name, COUNT(b.room_id) AS so_luong_phong
FROM customer c 
JOIN booking b ON c.customer_id = b.customer_id
JOIN payment p ON b.booking_id = p.booking_id
GROUP BY c.customer_id, c.customer_full_name
HAVING COUNT(b.room_id) >= 2
   AND SUM(p.payment_amount) > 1000
ORDER BY so_luong_phong DESC;

-- Lấy danh sách các phòng có tổng số tiền thanh toán dưới 1000 và có ít nhất 3 khách hàng đặt, 
--gồm mã phòng, loại phòng, giá phòng và tổng số tiền thanh toán 
SELECT r.room_id, r.room_type, r.room_price, COUNT(DISTINCT b.customer_id) AS so_lan_dat
FROM room r
JOIN booking b ON r.room_id = b.room_id
JOIN payment p ON b.booking_id = p.booking_id
GROUP BY r.room_id, r.room_type, r.room_price
HAVING SUM(p.payment_amount) < 1000
   AND COUNT(DISTINCT b.customer_id) >= 3
ORDER BY so_lan_dat DESC;

--Lấy danh sách các khách hàng có tổng số tiền thanh toán lớn hơn 1000,
-- gồm mã khách hàng, họ tên khách hàng, mã phòng, tổng số tiền thanh toán.
SELECT c.customer_id, c.customer_full_name, b.room_id, SUM(p.payment_amount) AS tong_tien
FROM customer c 
JOIN booking b ON c.customer_id = b.customer_id
JOIN payment p ON b.booking_id = p.booking_id
GROUP BY c.customer_id, c.customer_full_name, b.room_id
HAVING SUM(p.payment_amount) > 1000
ORDER BY tong_tien DESC;

--) Lấy danh sách các khách hàng Mmã KH, Họ tên, Email, SĐT) có họ tên chứa chữ "Minh" hoặc địa chỉ 
--(address) ở "Hanoi". Sắp xếp kết quả theo họ tên tăng dần.
SELECT customer_id, customer_full_name, customer_email, customer_phone
FROM customer
WHERE customer_full_name ILIKE '%Minh%'
   OR customer_address ILIKE '%Hanoi%'
ORDER BY customer_full_name ASC;    

--Lấy danh sách tất cả các phòng (Mã phòng, Loại phòng, Giá), sắp xếp theo giá phòng giảm dần.
-- Hiển thị 5 phòng tiếp theo sau 5 phòng đầu tiên (tức là lấy kết quả của trang thứ 2, biết mỗi trang có 5 phòng).
select c.customer_id , r.room_type,  r.room_price 
from customer c
join booking b on c.customer_id = b.customer_id
join room r on b.room_id = r.room_id
order by r.room_price desc
offset 5 limit 5;   

--Hãy tạo một view để lấy thông tin các phòng và khách hàng đã đặt, với điều kiện ngày nhận phòng
-- nhỏ hơn ngày 2025-03-10. Cần hiển thị các thông tin sau: Mã phòng, Loại phòng, Mã khách hàng, họ tên khách hàng
CREATE VIEW view_room_booking AS
SELECT r.room_id, r.room_type, c.customer_id, c.customer_full_name
FROM room r
JOIN booking b ON r.room_id = b.room_id
JOIN customer c ON b.customer_id = c.customer_id
WHERE b.check_in_date < '2025-03-10';

--(5 điểm) Hãy tạo một view để lấy thông tin khách hàng và phòng đã đặt, với điều kiện diệntích phòng
-- lớn hơn 30 m². Cần hiển thị các thông tin sau: Mã khách hàng, Họ tên khách hàng, Mã phòng, Diện tích phòng
CREATE VIEW view_customer_room AS
SELECT c.customer_id, c.customer_full_name, r.room_id, r.room_area  
FROM customer c
JOIN booking b ON c.customer_id = b.customer_id
JOIN room r ON b.room_id = r.room_id
WHERE r.room_area > 30; 

--(5 điểm) Hãy tạo một trigger check_insert_booking để kiểm tra dữ liệu mối khi chèn vào bảng Booking. 
--Kiểm tra nếu ngày đặt phòng mà sau ngày trả phòng thì thông báo lỗi với nội dung “Ngày đặt phòng không thể 
--sau ngày trả phòng được !” và hủy thao tác chèn dữ liệu vào bảng
CREATE OR REPLACE FUNCTION check_booking_dates()
RETURNS trigger AS $$
BEGIN
    IF NEW.check_in_date > NEW.check_out_date THEN
        RAISE EXCEPTION 'Ngày đặt phòng không thể sau ngày trả phòng được!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_insert_booking
    BEFORE INSERT ON booking
    FOR EACH ROW
    EXECUTE FUNCTION check_booking_dates();

--(5 điểm) Hãy tạo một trigger có tên là update_room_status_on_booking để tự động cập nhật trạng thái
-- phòng thành "Booked" khi một phòng được đặt (khi có bản ghi được INSERT vào bảng Booking).
CREATE OR REPLACE FUNCTION update_room_status()
RETURNS trigger AS $$
BEGIN
    UPDATE room
    SET room_status = 'Booked'
    WHERE room_id = NEW.room_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_room_status_on_booking
    AFTER INSERT ON booking
    FOR EACH ROW
    EXECUTE FUNCTION update_room_status();

--19. (5 điểm) Viết store procedure có tên add_customer để thêm mới một khách hàng với đầy đủ các thông tin cần thiết.
CREATE OR REPLACE PROCEDURE add_customer(
    p_full_name VARCHAR,
    p_email VARCHAR,
    p_phone VARCHAR,
    p_address VARCHAR
)LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO customer (customer_full_name, customer_email, customer_phone, customer_address)
    VALUES (p_full_name, p_email, p_phone, p_address);
END;
$$;

--(5 điểm) Hãy tạo một Stored Procedure có tên là add_payment để thực hiện việc thêmmột thanh toán mới cho 
--một lần đặt phòng.Procedure này nhận các tham số đầu vào:• p_booking_id: Mã đặt phòng (booking_id).
--• p_payment_method: Phương thức thanh toán (payment_method).• p_payment_amount: Số tiền thanh toán (payment_amount).• p_payment_date: Ngày thanh toán (payment_date)
CREATE OR REPLACE PROCEDURE add_payment(
    p_booking_id INT,
    p_payment_method VARCHAR,
    p_payment_amount NUMERIC,
    p_payment_date DATE
) LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO payment (booking_id, payment_method, payment_amount, payment_date)
    VALUES (p_booking_id, p_payment_method, p_payment_amount, p_payment_date);
END;
$$;

select* from room;
