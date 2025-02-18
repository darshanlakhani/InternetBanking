-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 17, 2025 at 10:05 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `internetbanking`
--

-- --------------------------------------------------------

--
-- Table structure for table `client_feedback`
--

CREATE TABLE `client_feedback` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `subject` varchar(255) NOT NULL,
  `feedback_message` text NOT NULL,
  `submission_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_feedback`
--

INSERT INTO `client_feedback` (`id`, `client_id`, `subject`, `feedback_message`, `submission_date`) VALUES
(3, 10, 'credit issue', 'Here\'s a detailed feedback message for a credit issue:\r\n\r\n\"I am writing to report ongoing issues with my credit card account. Over the past three months, I\'ve noticed several concerning problems that require immediate attention. First, there have been multiple instances of delayed transaction postings, sometimes taking 5-7 business days to appear on my account, making it difficult to track my spending accurately. On two occasions (January 15th and February 1st), I made payments at retail stores that were initially processed but then mysteriously disappeared from my transaction history, only to reappear several days later with different posting dates.\r\n\r\nAdditionally, I\'ve observed that my credit limit was suddenly reduced from Rs. 100,000 to Rs. 75,000 without any prior notification. This has caused significant inconvenience as I rely on this credit line for my business expenses. I\'ve tried contacting customer service through your phone system three times (reference numbers: #CR78901, #CR78955, and #CR79012), but have received inconsistent information about these issues.\r\n\r\nMost concerning is the fact that my last payment of Rs. 25,000, made on January 28th, 2025, was correctly deducted from my bank account but hasn\'t been reflected in my credit card balance even after 9 days. This has resulted in incorrect late payment fees being applied to my account.\r\n\r\nI would greatly appreciate if someone could thoroughly investigate these issues, particularly the missing payment and unauthorized credit limit reduction. This situation has caused considerable stress and has impacted my ability to manage my finances effectively. Please review my account history and provide a detailed explanation of these discrepancies, along with steps being taken to prevent such issues in the future.\r\n\r\nFor reference, I have maintained an excellent payment history for the past four years and would like to resolve these matters as soon as possible to continue our banking relationship posit', '2025-02-06 08:58:13');

-- --------------------------------------------------------

--
-- Table structure for table `credit_scores`
--

CREATE TABLE `credit_scores` (
  `id` int(11) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `score` int(11) NOT NULL DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ib_acc_types`
--

CREATE TABLE `ib_acc_types` (
  `acctype_id` int(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `rate` varchar(200) NOT NULL,
  `code` varchar(200) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ib_acc_types`
--

INSERT INTO `ib_acc_types` (`acctype_id`, `name`, `description`, `rate`, `code`, `is_active`) VALUES
(1, 'Savings', '<p>Savings accounts&nbsp;are typically the first official bank account anybody opens. Children may open an account with a parent to begin a pattern of saving. Teenagers open accounts to stash cash earned&nbsp;from a first job&nbsp;or household chores.</p><p>Savings accounts are an excellent place to park&nbsp;emergency cash. Opening a savings account also marks the beginning of your relationship with a financial institution. For example, when joining a credit union, your &ldquo;share&rdquo; or savings account establishes your membership.</p>', '20', 'ACC-CAT-4EZFO', 1),
(2, ' Retirement', '<p>Retirement accounts&nbsp;offer&nbsp;tax advantages. In very general terms, you get to&nbsp;avoid paying income tax on interest&nbsp;you earn from a savings account or CD each year. But you may have to pay taxes on those earnings at a later date. Still, keeping your money sheltered from taxes may help you over the long term. Most banks offer IRAs (both&nbsp;Traditional IRAs&nbsp;and&nbsp;Roth IRAs), and they may also provide&nbsp;retirement accounts for small businesses</p>', '10', 'ACC-CAT-1QYDV', 1),
(4, 'Recurring deposit', '<p><strong>Recurring deposit account or RD account</strong> is opened by those who want to save certain amount of money regularly for a certain period of time and earn a higher interest rate.&nbsp;In RD&nbsp;account a&nbsp;fixed amount is deposited&nbsp;every month for a specified period and the total amount is repaid with interest at the end of the particular fixed period.&nbsp;</p><p>The period of deposit is minimum six months and maximum ten years.&nbsp;The interest rates vary&nbsp;for different plans based on the amount one saves and the period of time and also on banks. No withdrawals are allowed from the RD account. However, the bank may allow to close the account before the maturity period.</p><p>These accounts can be opened in single or joint names. Banks are also providing the Nomination facility to the RD account holders.&nbsp;</p>', '15', 'ACC-CAT-VBQLE', 1),
(5, 'Fixed Deposit Account', '<p>In <strong>Fixed Deposit Account</strong> (also known as <strong>FD Account</strong>), a particular sum of money is deposited in a bank for specific&nbsp;period of time. It&rsquo;s one time deposit and one time take away (withdraw) account.&nbsp;The money deposited in this account can not be withdrawn before the expiry of period.&nbsp;</p><p>However, in case of need,&nbsp; the depositor can ask for closing the fixed deposit prematurely by paying a penalty. The penalty amount varies with banks.</p><p>A high interest rate is paid on fixed deposits. The rate of interest paid for fixed deposit vary according to amount, period and also from bank to bank.</p>', '40', 'ACC-CAT-A86GO', 1),
(7, 'Current account', '<p><strong>Current account</strong> is mainly for business persons, firms, companies, public enterprises etc and are never used for the purpose of investment or savings.These deposits are the most liquid deposits and there are no limits for number of transactions or the amount of transactions in a day. While, there is no interest paid on amount held in the account, banks charges certain &nbsp;service charges, on such accounts. The current accounts do not have any fixed maturity as these are on continuous basis accounts.</p>', '20', 'ACC-CAT-4O8QW', 1),
(8, 'Salary Account', '<p>A <strong>salary account</strong> is a bank account where an employer directly deposits an employee&rsquo;s salary. It usually has <strong>zero balance requirements</strong>, <strong>free debit card and chequebook</strong>, <strong>higher transaction limits</strong>, <strong>overdraft facility</strong>, and <strong>easy loan approvals</strong>. It also provides <strong>internet and mobile banking</strong> for seamless transactions.</p>', '6.5', 'ACC-CAT-27DQV', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ib_admin`
--

CREATE TABLE `ib_admin` (
  `admin_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `number` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `profile_pic` varchar(200) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ib_admin`
--

INSERT INTO `ib_admin` (`admin_id`, `name`, `email`, `number`, `password`, `profile_pic`, `is_active`) VALUES
(2, 'System Administrator', 'admin@mail.com', 'iBank-ADM-0516', '976d54d986d54e88a0a0610ea4f46c9896a49883', 'admin-icn.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ib_bankaccounts`
--

CREATE TABLE `ib_bankaccounts` (
  `account_id` int(20) NOT NULL,
  `acc_name` varchar(200) NOT NULL,
  `account_number` varchar(200) NOT NULL,
  `acc_type` varchar(200) NOT NULL,
  `acc_rates` varchar(200) NOT NULL,
  `acc_status` varchar(200) NOT NULL,
  `acc_amount` decimal(10,2) NOT NULL,
  `client_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ib_bankaccounts`
--

INSERT INTO `ib_bankaccounts` (`account_id`, `acc_name`, `account_number`, `acc_type`, `acc_rates`, `acc_status`, `acc_amount`, `client_id`, `created_at`, `is_active`) VALUES
(14, 'Hari pandya', '357146928', 'Current account ', '20', 'Active', 0.00, 5, '2025-02-16 16:18:47.051007', 1),
(15, 'Amanda Stiefel', '287359614', 'Savings ', '20', 'Active', 0.00, 8, '2023-02-16 16:14:54.629958', 1),
(16, 'Johnnie Reyes', '705239816', ' Retirement ', '10', 'Active', 0.00, 6, '2023-02-16 16:19:11.806028', 1),
(18, 'Johnny M. Doen', '724310586', 'Fixed Deposit Account ', '40', 'Active', 0.00, 3, '2023-02-16 16:40:15.645285', 1),
(19, 'Jenil Dhola', '864790325', 'Savings ', '20', 'Active', 0.00, 10, '2024-12-16 14:41:59.893479', 1),
(20, 'kirtanmoradiya', '730459816', ' Retirement ', '10', 'Active', 0.00, 10, '2024-12-16 14:45:28.603301', 1),
(23, 'kirtan moradiya', '573608192', 'Savings ', '20', 'Active', 0.00, 11, '2025-02-02 05:54:54.725303', 1),
(24, 'Jenil Dhola', '529714806', 'Recurring deposit ', '15', 'Active', 0.00, 11, '2025-02-03 16:20:40.303951', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ib_clients`
--

CREATE TABLE `ib_clients` (
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `address` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `profile_pic` varchar(200) NOT NULL,
  `client_number` varchar(200) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ib_clients`
--

INSERT INTO `ib_clients` (`client_id`, `name`, `phone`, `address`, `email`, `password`, `profile_pic`, `client_number`, `is_active`) VALUES
(3, 'John Doe', '9897890089', '127007 Localhost', 'johndoe@gmail.com', 'a69681bcf334ae130217fea4505fd3c994f5683f', '', 'iBank-CLIENT-8127', 1),
(5, 'Harry Den', '7412560000', '114 Allace Avenue', 'harryden@mail.com', '55c3b5386c486feb662a0785f340938f518d547f', '', 'iBank-CLIENT-7014', 1),
(6, 'Johnnie J. Reyes', '7412545454', '23 Hinkle Deegan Lake Road', 'reyes@mail.com', '55c3b5386c486feb662a0785f340938f518d547f', 'user-profile-min.png', 'iBank-CLIENT-1698', 1),
(8, 'Amanda Stiefel', '7850000014', '92 Maple Street', 'amanda@mail.com', '55c3b5386c486feb662a0785f340938f518d547f', 'user-profile-min.png', 'iBank-CLIENT-0423', 1),
(9, 'Liam Moore', '7014569696', '46 Timberbrook Lane', 'liamoore@mail.com', '55c3b5386c486feb662a0785f340938f518d547f', 'user-profile-min.png', 'iBank-CLIENT-4716', 1),
(10, 'Jenil Dhola', '8799050118', 'A/2 -203,devi complex,dabholi char rasta,ved road,surat', 'jenildhola1811@gmail.com', '1a0c80f1d0253ae78fcf2a32e15ac686533063f1', '', 'iBank-CLIENT-6482', 1),
(11, 'kirtanmoradiya', '9979735065', 'A-2/203,DEVI COMPLEX,DABHOLI CHAR RASTA', 'shreeji.gamer.bot@gmail.com', '1a0c80f1d0253ae78fcf2a32e15ac686533063f1', '', 'iBank-CLIENT-2438', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ib_notifications`
--

CREATE TABLE `ib_notifications` (
  `notification_id` int(20) NOT NULL,
  `notification_details` text NOT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ib_notifications`
--

INSERT INTO `ib_notifications` (`notification_id`, `notification_details`, `created_at`, `is_active`) VALUES
(30, 'Christine Moore Has Transfered Rs.20 From Bank Account 421873905 To Bank Account 287359614', '2024-12-16 14:37:17.891954', 1),
(31, 'Jenil Dhola has deposited Rs.100000 into bank account 864790325', '2024-12-16 14:42:23.963486', 1),
(32, 'Jenil Dhola Has Withdrawn Rs. 100 From Bank Account 864790325', '2024-12-16 14:42:35.789915', 1),
(33, 'Jenil Dhola Has Transferred Rs.50000 From Bank Account 864790325 To Bank Account 724310586', '2024-12-16 14:42:46.593408', 1),
(34, 'Jenil Dhola has deposited Rs.100 into bank account 864790325', '2025-01-16 09:28:30.966334', 1),
(35, 'kirtanmoradiya has deposited Rs.50000 into bank account 573608192', '2025-02-02 05:55:05.862578', 1),
(36, 'kirtanmoradiya Has Withdrawn Rs. 10000 From Bank Account 573608192', '2025-02-02 07:12:37.265701', 1),
(37, 'kirtanmoradiya Has Transferred Rs.100 From Bank Account 573608192 To Bank Account 287359614', '2025-02-02 07:12:56.670711', 1),
(38, 'Christine Moore has deposited Rs.100 to bank account 421873905', '2025-02-03 17:20:33.553365', 1),
(39, '<br /><b>Warning</b>:  Undefined property: stdClass::$client_name in <b>C:\\xampp\\htdocs\\InternetBanking\\staff\\pages_deposit_money.php</b> on line <b>118</b><br /> has deposited Rs.1000000 to bank account 357146928', '2025-02-16 16:23:51.943661', 1),
(40, '<br /><b>Warning</b>:  Undefined property: stdClass::$client_name in <b>C:\\xampp\\htdocs\\InternetBanking\\staff\\pages_deposit_money.php</b> on line <b>118</b><br /> has deposited Rs.1000000 to bank account 357146928', '2025-02-16 16:25:07.817697', 1),
(41, '<br /><b>Warning</b>:  Undefined property: stdClass::$client_name in <b>C:\\xampp\\htdocs\\InternetBanking\\staff\\pages_deposit_money.php</b> on line <b>118</b><br /> has deposited Rs.1000000 to bank account 357146928', '2025-02-16 16:26:10.091163', 1),
(42, '<br /><b>Warning</b>:  Undefined property: stdClass::$client_name in <b>C:\\xampp\\htdocs\\InternetBanking\\staff\\pages_deposit_money.php</b> on line <b>118</b><br /> has deposited Rs.1000000 to bank account 357146928', '2025-02-16 16:26:30.431084', 1),
(43, '<br /><b>Warning</b>:  Undefined property: stdClass::$client_name in <b>C:\\xampp\\htdocs\\InternetBanking\\staff\\pages_deposit_money.php</b> on line <b>118</b><br /> has deposited Rs.1000000 to bank account 357146928', '2025-02-16 16:29:27.999800', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ib_staff`
--

CREATE TABLE `ib_staff` (
  `staff_id` int(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `staff_number` varchar(200) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `sex` varchar(200) NOT NULL,
  `profile_pic` varchar(200) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ib_staff`
--

INSERT INTO `ib_staff` (`staff_id`, `name`, `staff_number`, `phone`, `email`, `password`, `sex`, `profile_pic`, `is_active`) VALUES
(3, 'Suresh bhat', 'iBank-STAFF-6785', '0704975742', 'staff@mail.com', '8f59184db68820a83838cf4123474df2294be113', 'Male', 'v1.jpg', 1),
(4, 'Krishna', 'iBank-STAFF-6724', '9265460571', 'krishna@gmail.com', 'd95d3bbedb4dcba5a8e891968853002354b028e9', 'Female', 'pexels-pixabay-415263.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ib_systemsettings`
--

CREATE TABLE `ib_systemsettings` (
  `id` int(20) NOT NULL,
  `sys_name` longtext NOT NULL,
  `sys_tagline` longtext NOT NULL,
  `sys_logo` varchar(200) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ib_systemsettings`
--

INSERT INTO `ib_systemsettings` (`id`, `sys_name`, `sys_tagline`, `sys_logo`, `is_active`) VALUES
(1, 'DigiBankX', 'Digital banking revolution', 'bank.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ib_transactions`
--

CREATE TABLE `ib_transactions` (
  `tr_id` int(20) NOT NULL,
  `tr_code` varchar(200) NOT NULL,
  `account_id` int(20) NOT NULL,
  `tr_type` varchar(200) NOT NULL,
  `tr_status` varchar(200) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `transaction_amt` varchar(200) NOT NULL,
  `receiving_acc_no` varchar(200) NOT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ib_transactions`
--

INSERT INTO `ib_transactions` (`tr_id`, `tr_code`, `account_id`, `tr_type`, `tr_status`, `client_id`, `transaction_amt`, `receiving_acc_no`, `created_at`, `is_active`) VALUES
(41, 'RGl1EohqrgS3K4MUAHaf', 14, 'Deposit', '0', 5, '2660', '', '2023-01-10 15:47:21.233304', 1),
(43, 'wXOyVgizubsp6UnTNfL4', 15, 'Deposit', '0', 8, '2658', '', '2023-02-16 16:17:22.506549', 1),
(47, 'm2OlYZgkQwTPp5VHS9WN', 18, 'Deposit', '0', 3, '8550', '', '2023-02-16 16:40:49.466257', 1),
(50, '9jQsTd0YV6tfqCZzckGW', 18, 'Transfer', '0', 3, '100', '719360482', '2023-02-16 16:41:38.758246', 1),
(52, 'nwcoipUr1Wt6ujzF94If', 14, 'Withdrawal', '0', 5, '1200', '', '2024-12-16 14:36:56.666575', 1),
(54, 'Y32hjWt1VxgZUkHySPTn', 19, 'Deposit', '0', 10, '100000', '', '2024-12-16 14:42:23.960810', 1),
(55, 'gPcq8CmQaSFZ4XhATpNf', 19, 'Withdrawal', '0', 10, '100', '', '2024-12-16 14:42:35.787442', 1),
(57, 'bO9iTXM2BFtG3JsnzQZq', 19, 'Deposit', '0', 10, '100', '', '2025-01-16 09:28:30.963246', 1),
(58, '6lPYMrOWs7mQ4zvhTaq0', 23, 'Deposit', '0', 11, '50000', '', '2025-02-02 05:55:05.860097', 1),
(59, '60KZohremxwnXdHaMTp7', 23, 'Withdrawal', '0', 11, '10000', '', '2025-02-02 07:12:37.262622', 1),
(60, 'ZVgAWGaqv8DbXf75xtCB', 23, 'Transfer', '0', 11, '100', '287359614', '2025-02-02 07:12:56.670065', 1),
(62, 'TGBlaxIMc7ets4U8Cd30', 14, 'Deposit', '0', 5, '1000000', '', '2025-02-16 16:23:51.941025', 1),
(67, 'F3j8RqelYBaPm597czrJ', 14, 'Transfer', '0', 5, '2000', '724310586', '2025-02-17 06:43:10.000000', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ib_transactions_backup`
--

CREATE TABLE `ib_transactions_backup` (
  `tr_id` int(20) NOT NULL DEFAULT 0,
  `tr_code` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `account_id` int(20) NOT NULL,
  `acc_name` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `account_number` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `acc_type` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `acc_amount` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tr_type` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tr_status` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `client_name` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `client_national_id` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `transaction_amt` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `client_phone` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `receiving_acc_no` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `receiving_acc_name` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `receiving_acc_holder` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ib_transactions_backup`
--

INSERT INTO `ib_transactions_backup` (`tr_id`, `tr_code`, `account_id`, `acc_name`, `account_number`, `acc_type`, `acc_amount`, `tr_type`, `tr_status`, `client_id`, `client_name`, `client_national_id`, `transaction_amt`, `client_phone`, `receiving_acc_no`, `created_at`, `receiving_acc_name`, `receiving_acc_holder`, `is_active`) VALUES
(41, 'RGl1EohqrgS3K4MUAHaf', 14, 'Harry M Den', '357146928', 'Savings ', '', 'Deposit', '0', 5, 'Harry Den', '100014001000', '2660', '7412560000', '', '2023-01-10 15:47:21.233304', '', '', 1),
(43, 'wXOyVgizubsp6UnTNfL4', 15, 'Amanda Stiefel', '287359614', 'Savings ', '', 'Deposit', '0', 8, 'Amanda Stiefel', '478000001', '2658', '7850000014', '', '2023-02-16 16:17:22.506549', '', '', 1),
(47, 'm2OlYZgkQwTPp5VHS9WN', 18, 'Johnny M. Doen', '724310586', 'Fixed Deposit Account ', '', 'Deposit', '0', 3, 'John Doe', '36756481', '8550', '9897890089', '', '2023-02-16 16:40:49.466257', '', '', 1),
(50, '9jQsTd0YV6tfqCZzckGW', 18, 'Johnny M. Doen', '724310586', 'Fixed Deposit Account ', '', 'Transfer', '0', 3, 'John Doe', '36756481', '100', '9897890089', '719360482', '2023-02-16 16:41:38.758246', 'Liam M. Moore', 'Liam Moore', 1),
(52, 'nwcoipUr1Wt6ujzF94If', 14, 'Harry M Den', '357146928', 'Savings ', '', 'Withdrawal', '0', 5, 'Harry Den', '', '1200', '7412560000', '', '2024-12-16 14:36:56.666575', '', '', 1),
(54, 'Y32hjWt1VxgZUkHySPTn', 19, 'Jenil Dhola', '864790325', 'Savings ', '', 'Deposit', '0', 10, 'Jenil Dhola', '', '100000', '8799050118', '', '2024-12-16 14:42:23.960810', '', '', 1),
(55, 'gPcq8CmQaSFZ4XhATpNf', 19, 'Jenil Dhola', '864790325', 'Savings ', '', 'Withdrawal', '0', 10, 'Jenil Dhola', '', '100', '8799050118', '', '2024-12-16 14:42:35.787442', '', '', 1),
(57, 'bO9iTXM2BFtG3JsnzQZq', 19, 'Jenil Dhola', '864790325', 'Savings ', '', 'Deposit', '0', 10, 'Jenil Dhola', '', '100', '8799050118', '', '2025-01-16 09:28:30.963246', '', '', 1),
(58, '6lPYMrOWs7mQ4zvhTaq0', 23, 'kirtan moradiya', '573608192', 'Savings ', '', 'Deposit', '0', 11, 'kirtanmoradiya', '', '50000', '9979735065', '', '2025-02-02 05:55:05.860097', '', '', 1),
(59, '60KZohremxwnXdHaMTp7', 23, 'kirtan moradiya', '573608192', 'Savings ', '', 'Withdrawal', '0', 11, 'kirtanmoradiya', '', '10000', '9979735065', '', '2025-02-02 07:12:37.262622', '', '', 1),
(60, 'ZVgAWGaqv8DbXf75xtCB', 23, 'kirtan moradiya', '573608192', 'Savings ', '', 'Transfer', '0', 11, 'kirtanmoradiya', '', '100', '9979735065', '287359614', '2025-02-02 07:12:56.670065', 'Amanda Stiefel', 'Amanda Stiefel', 1),
(62, 'TGBlaxIMc7ets4U8Cd30', 14, 'Hari pandya', '357146928', 'Current account ', '', 'Deposit', '0', 5, '<br /><b>Warning</b>:  Undefined property: stdClass::$client_name in <b>C:\\xampp\\htdocs\\InternetBanking\\staff\\pages_deposit_money.php</b> on line <b>118</b><br />', '', '1000000', '<br /><b>Warning</b>:  Undefined property: stdClass::$client_phone in <b>C:\\xampp\\htdocs\\InternetBanking\\staff\\pages_deposit_money.php</b> on line <b>123</b><br />', '', '2025-02-16 16:23:51.941025', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `loan_applications`
--

CREATE TABLE `loan_applications` (
  `id` int(10) UNSIGNED NOT NULL,
  `applicant_name` varchar(255) NOT NULL,
  `loan_amount` decimal(10,2) NOT NULL,
  `application_date` datetime DEFAULT current_timestamp(),
  `status` enum('pending','approved','rejected','recommended') NOT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `admin_review_id` int(11) DEFAULT NULL,
  `review_date` datetime DEFAULT NULL,
  `staff_remark` text DEFAULT NULL,
  `admin_remark` text NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `loan_type_id` int(11) DEFAULT NULL,
  `is_approved_by_staff` tinyint(1) DEFAULT 0,
  `income_salary` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_applications`
--

INSERT INTO `loan_applications` (`id`, `applicant_name`, `loan_amount`, `application_date`, `status`, `reviewed_by`, `admin_review_id`, `review_date`, `staff_remark`, `admin_remark`, `client_id`, `loan_type_id`, `is_approved_by_staff`, `income_salary`) VALUES
(4, 'John Doe', 7500.00, '2025-02-04 10:00:00', 'approved', 3, 2, '2025-02-17 13:33:51', 'dvd', 'i app', 11, 2, 0, 0.00),
(7, 'Abc', 2345.00, '2025-02-04 12:58:32', 'approved', 3, 2, '2025-02-17 13:35:02', 'd', 'appp', 11, 3, 0, 0.00),
(8, 'Darshan', 300000.00, '2025-02-04 12:59:46', 'rejected', 3, 2, '2025-02-17 13:18:49', 'yoo', 'sadssdsdsdf', 11, 10, 0, 0.00),
(13, 'Jenil Dineshbhai dhola', 10000.00, '2025-02-16 18:36:01', 'approved', 3, 2, '2025-02-17 13:20:03', 'GOOD', 'reject', 10, 3, 0, 0.00),
(14, 'utsav cheta', 100000.00, '2025-02-16 18:55:04', 'pending', 3, 2, NULL, 'HEYY', '', 10, 2, 0, 50000.00),
(15, 'Darshan', 20.00, '2025-02-17 14:34:24', 'pending', NULL, NULL, NULL, 'Nathi apvi', 'Pending Review', 11, 7, 0, 10.00);

-- --------------------------------------------------------

--
-- Table structure for table `loan_types`
--

CREATE TABLE `loan_types` (
  `id` int(11) NOT NULL,
  `type_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `max_amount` decimal(15,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_types`
--

INSERT INTO `loan_types` (`id`, `type_name`, `description`, `interest_rate`, `max_amount`, `created_at`, `is_active`) VALUES
(2, 'Home_Loan', 'A Home Loan is a long-term financial product designed to help individuals buy property.', 8.25, 5000000.00, '2025-02-04 05:48:43', 1),
(3, 'Car_Loan', 'A Car Loan is used to finance the purchase of a vehicle, often with fixed interest rates.', 7.50, 30000.00, '2025-02-04 05:48:43', 1),
(4, 'Personal_Loan', 'A Personal Loan is an unsecured loan for personal expenses such as travel or medical needs.', 10.00, 20000.00, '2025-02-04 05:48:43', 1),
(5, 'Education_Loan', 'An Education Loan helps students finance their tuition and other academic expenses.', 5.75, 100000.00, '2025-02-04 05:48:43', 1),
(6, 'Business_Loan', 'A Business Loan provides funds to entrepreneurs and companies for business growth.', 9.00, 250000.00, '2025-02-04 05:48:43', 1),
(7, 'Gold_Loan', 'A Gold Loan is secured against gold jewelry and has a lower interest rate.', 6.50, 50000.00, '2025-02-04 05:48:43', 1),
(8, 'Credit_Card_Loan', 'A Credit Card Loan is an extension of credit card limits for financial flexibility.', 12.50, 15000.00, '2025-02-04 05:48:43', 1),
(9, 'Agriculture_Loan', 'An Agriculture Loan supports farmers in purchasing equipment, seeds, and livestock.', 4.50, 120000.00, '2025-02-04 05:48:43', 1),
(10, 'Mortgage_Loan', 'A Mortgage Loan allows individuals to borrow against the value of their property.', 7.80, 450000.00, '2025-02-04 05:48:43', 1),
(11, 'Two_Wheeler_Loan', 'A Two-Wheeler Loan is used to finance the purchase of motorcycles and scooters.', 8.00, 80000.00, '2025-02-04 05:48:43', 1),
(12, 'ACC', 'xyz', 13.00, 4000000.00, '2025-02-17 08:35:54', 1),
(13, 'ACC', 'xyz', 3.00, 4000000.00, '2025-02-17 08:41:27', 0);

-- --------------------------------------------------------

--
-- Table structure for table `otp_verification`
--

CREATE TABLE `otp_verification` (
  `id` int(11) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `token` varchar(64) NOT NULL,
  `expiry` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `admin_id`, `token`, `expiry`) VALUES
(1, 2, 'bdbae7f327ee9d12d0c5c47a5bee32db6828d3fed359ef8caaf6d77fb192350a', '2025-01-21 15:43:18'),
(2, 2, 'd5cd7042b2dfc604af69a4f7fbf752bffc0f95c564f3bcf1a15a12fbb5714b72', '2025-01-23 15:41:40'),
(3, 2, 'bdb9e6e793564daa0689436de8b68a372335dcb5a040edcb4a47cf326a3d476e', '2025-01-23 15:41:42'),
(4, 2, '4478e3d37bfbf2e8e4f5816ca4559aff7de939cf3105d4514c9fd2e6636ad151', '2025-01-23 16:02:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `client_feedback`
--
ALTER TABLE `client_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `credit_scores`
--
ALTER TABLE `credit_scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `ib_acc_types`
--
ALTER TABLE `ib_acc_types`
  ADD PRIMARY KEY (`acctype_id`);

--
-- Indexes for table `ib_admin`
--
ALTER TABLE `ib_admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `ib_bankaccounts`
--
ALTER TABLE `ib_bankaccounts`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `fk_ib_bankaccounts_clients` (`client_id`);

--
-- Indexes for table `ib_clients`
--
ALTER TABLE `ib_clients`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `ib_notifications`
--
ALTER TABLE `ib_notifications`
  ADD PRIMARY KEY (`notification_id`);

--
-- Indexes for table `ib_staff`
--
ALTER TABLE `ib_staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `ib_systemsettings`
--
ALTER TABLE `ib_systemsettings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ib_transactions`
--
ALTER TABLE `ib_transactions`
  ADD PRIMARY KEY (`tr_id`),
  ADD KEY `fk_account` (`account_id`),
  ADD KEY `fk_client` (`client_id`);

--
-- Indexes for table `loan_applications`
--
ALTER TABLE `loan_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviewed_by` (`reviewed_by`),
  ADD KEY `loan_type_id` (`loan_type_id`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `fk_admin_review` (`admin_review_id`);

--
-- Indexes for table `loan_types`
--
ALTER TABLE `loan_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `otp_verification`
--
ALTER TABLE `otp_verification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `client_feedback`
--
ALTER TABLE `client_feedback`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `credit_scores`
--
ALTER TABLE `credit_scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ib_acc_types`
--
ALTER TABLE `ib_acc_types`
  MODIFY `acctype_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `ib_admin`
--
ALTER TABLE `ib_admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ib_bankaccounts`
--
ALTER TABLE `ib_bankaccounts`
  MODIFY `account_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `ib_clients`
--
ALTER TABLE `ib_clients`
  MODIFY `client_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `ib_notifications`
--
ALTER TABLE `ib_notifications`
  MODIFY `notification_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `ib_staff`
--
ALTER TABLE `ib_staff`
  MODIFY `staff_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ib_systemsettings`
--
ALTER TABLE `ib_systemsettings`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ib_transactions`
--
ALTER TABLE `ib_transactions`
  MODIFY `tr_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `loan_applications`
--
ALTER TABLE `loan_applications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `loan_types`
--
ALTER TABLE `loan_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `otp_verification`
--
ALTER TABLE `otp_verification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `client_feedback`
--
ALTER TABLE `client_feedback`
  ADD CONSTRAINT `client_feedback_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `ib_clients` (`client_id`) ON DELETE CASCADE;

--
-- Constraints for table `credit_scores`
--
ALTER TABLE `credit_scores`
  ADD CONSTRAINT `credit_scores_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `ib_clients` (`client_id`) ON DELETE CASCADE;

--
-- Constraints for table `ib_bankaccounts`
--
ALTER TABLE `ib_bankaccounts`
  ADD CONSTRAINT `fk_ib_bankaccounts_clients` FOREIGN KEY (`client_id`) REFERENCES `ib_clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ib_transactions`
--
ALTER TABLE `ib_transactions`
  ADD CONSTRAINT `fk_account` FOREIGN KEY (`account_id`) REFERENCES `ib_bankaccounts` (`account_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_client` FOREIGN KEY (`client_id`) REFERENCES `ib_clients` (`client_id`) ON DELETE CASCADE;

--
-- Constraints for table `loan_applications`
--
ALTER TABLE `loan_applications`
  ADD CONSTRAINT `fk_admin_review` FOREIGN KEY (`admin_review_id`) REFERENCES `ib_admin` (`admin_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_client_id` FOREIGN KEY (`client_id`) REFERENCES `ib_clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `loan_applications_ibfk_1` FOREIGN KEY (`reviewed_by`) REFERENCES `ib_staff` (`staff_id`),
  ADD CONSTRAINT `loan_applications_ibfk_2` FOREIGN KEY (`loan_type_id`) REFERENCES `loan_types` (`id`);

--
-- Constraints for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `password_resets_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `ib_admin` (`admin_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
