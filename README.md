# Arithmetic Logic Unit (ALU)

1.1 Introduction
Thiết kế một ALU có thể thực hiện một tập con các phép toán của một ALU đầy đủ trong bộ xử lý.
![image](https://github.com/user-attachments/assets/fd2fe5a9-e9b1-4357-81ff-46580c90a949)

                                        
Trong bài tập này, chúng ta sẽ phát triển một ALU nhận hai đầu vào A và B và có khả năng thực hiện các lệnh sau:		
![image](https://github.com/user-attachments/assets/757458dd-7aa6-49b7-9141-3141e2b643e5)

ALU sẽ tạo ra một đầu ra 32-bit gọi là 'Result' và một cờ 1-bit bổ sung gọi là 'Zero'. Cờ 'Zero' sẽ được đặt thành 'logic-1' nếu tất cả các bit của 'Result' đều bằng 0. Các phép toán khác nhau sẽ được chọn bởi một tín hiệu điều khiển 4-bit gọi là 'ALUControl' theo bảng phái trên. 
Ví dụ,  Khi 'ALUControl' là 0000, ALU sẽ thực hiện phép cộng hai đầu vào A và B.
 - Khi 'ALUControl' là 0001, ALU sẽ thực hiện phép trừ giữa A và B.
 - Khi 'ALUControl' là 0010, ALU sẽ thực hiện phép toán AND bit giữa A và B.
 - Khi 'ALUControl' là 0011, ALU sẽ thực hiện phép toán OR bit giữa A và B.
 - Khi 'ALUControl' là 0100, ALU sẽ thực hiện phép nhân giữa A và B.
 - Khi 'ALUControl' là 0101, ALU sẽ thực hiện phép chia lấy phần nguyên giữa A và B.
 - Khi 'ALUControl' là 0110, ALU sẽ thực hiện dịch phải 1 bit trên A.
 - Khi 'ALUControl' là 0111, ALU sẽ thực hiện dịch trái 1 bit trên A.
 - Khi 'ALUControl' là 1000, ALU sẽ thực hiện so sánh giữa A và B.	
 - Khi 'ALUControl' là 1009, ALU sẽ lấy bit dấu của tổng (sum) của A và B.
 - Khi 'ALUControl' là 1010, ALU sẽ thực hiện phép chia lấy phần dư giữa A và B.                                                     1.2 Sơ đồ khối
 
1.2 Sơ đồ khối
Đầu tiên, hãy xem xét các lệnh khác nhau. Có thể thấy rằng chúng ta có các loại lệnh: các lệnh cộng, trừ, nhân, chia lấy phần nguyên, chia lấy phần dư và so sánh là các phép toán số học, lệnh AND và OR là các phép toán logic và lệnh dịch trái, dịch phải. Tương ứng với các ALUControl thích hợp
![image](https://github.com/user-attachments/assets/8e0dd8f5-494d-485d-909e-2eaf50d99b55)

Từ hình trên ta có thể thấy khi ALUControl[0] bằng 0 thì ALU thực hiện phép cộng, ngược lại khi ALUControl[0] = 1 thì ALU thực hiện phép trừ.
![image](https://github.com/user-attachments/assets/359789c1-98e3-4d9c-bd28-7636b5170a96)


 ![image](https://github.com/user-attachments/assets/3c02b11e-8ab6-41c5-adcf-7abab94b69a5)

Tính toán tràn số (overflow) đối với phép cộng và trừ:
•	Sum[31] ^ A[31]: So sánh bit dấu của kết quả (Sum[31]) với bit dấu của toán hạng đầu tiên (A[31]). Nếu chúng khác nhau, có khả năng đã xảy ra tràn số.
•	~(ALUControl[0] ^ B[31] ^ A[31]): Xác định điều kiện tràn số cho phép cộng và trừ. Đây là điều kiện kiểm tra xem phép toán là phép cộng hay phép trừ, và nếu các bit dấu của hai toán hạng đầu vào (A và B) và bit dấu của kết quả (Sum) không tương ứng đúng, có thể dẫn đến tràn số.
o	ALUControl[0]: Xác định phép cộng hoặc trừ (nếu ALUControl[0] là 0 thì là phép cộng, còn nếu là 1 thì là phép trừ).
•	~ALUControl[1]: Cờ tràn số chỉ được áp dụng cho phép cộng và trừ. ALUControl[1] phân biệt giữa các phép toán, vì vậy ~ALUControl[1] đảm bảo phép toán là phép cộng hoặc trừ.
Tính toán cờ dư cho phép cộng và trừ:
•	~ALUControl[1]: Đảm bảo chỉ tính toán cờ dư khi phép toán là phép cộng (hoặc phép trừ, nếu ALUControl[1] là 0 thì đây là phép cộng, còn nếu là 1 thì là phép trừ).
•	Cout: Carry-out từ phép cộng hoặc trừ.
Kiểm tra nếu kết quả bằng 0:
•	~Result: Lật tất cả các bit của Result.
•	&: Toán tử AND tất cả các bit của ~Result. Nếu tất cả các bit của ~Result là 1, tức là Result là 0, và Zero sẽ được thiết lập.
Kiểm tra bit dấu của kết quả:
•	Result[31]: Bit quan trọng nhất của Result (bit dấu). Nếu là 1, nghĩa là kết quả là số âm theo quy ước dấu bù 2.
