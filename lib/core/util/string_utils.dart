const String appName="Car Rental System";
const String splashScreenTitle="RENTAL";
//images from assets
const String logoPath="assets/images/logo.png";
const String letsStartImagePath="assets/images/lets_start.png";
const String googleLogoPath="assets/images/google_logo.png";
const String facebookLogoPath="assets/images/facebook_logo.png";
const String createAccountStr="Create Account";
const String welcomeBackStr="Welcom Back";
const String alreadyHaveAccountStr="Already have an account? ";
const String dontHaveAccountStr="Dont have an account? ";
const String loginStr="Log In";
const String getStartedTitleStr="Lets get Started";
const String getStartedSubTitleStr="We welcome you to the car rental app where your time is our priority and your safety is out motto";
const String nameStr="Name";
const String nameHintStr="Enter your name";
const String validateNameStr="PLease enter name";
const String validateNameRegexStr="PLease enter name only containing letters and spaces";
const String namePatternStr = r'^[A-Za-z]+(?: [A-Za-z]+)*$';
RegExp nameRegex = RegExp(namePatternStr);

const String emailAddressStr="Email Address";
const String emailAddressHintStr="Enter your email address";
const String validateEmailAddressStr="PLease enter email";
const String validateEmailAddressRegexStr="PLease enter email address with @ and proper format";
const String emailPatternStr = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
RegExp emailRegex = RegExp(emailPatternStr);

const String passwordStr="Password";
const String passwordHintStr="Enter password";
const String validatePasswordStr="PLease enter password ";
const String validatePasswordRegexStr="PLease enter password with at least 8 characters long, contain at least one uppercase letter and one number";
const String passwordPatternStr = r'^(?=.*[A-Z])(?=.*\d).{8,}$';
RegExp passwordRegex = RegExp(passwordPatternStr);

const String agreeTermsAndConditionStr='I agree to the terms and conditions';
const String notAgreedToTermsAndConditionsMessage="PLease agree to terms and condition to signup";
const String registerStr="Register";
const String orStr="Or";

const String loginSuccessfullyStr="Logged in successfully";
const String failedStr="Failed !";
const String credentialsDidnotMatchStr="Credentials didnot match";
const String rememberMeStr="Remember Me";
const String forgotPasswordStr="Forgot Passwoord";
const String sendCodeStr="Send Code";
const String verifyAccountStr="Verify Account";
const String didntReceiveOtpStr="Didn't recieve otp? ";
const String resendOtpStr="Re-send";
const String validateOtpStr="PLease enter valid otp";

const String newPasswordStr="New Password";
const String confirmPasswordStr="Confirm Password";
const String resetPasswordStr="Reset Password";
const String passwordDidntMatchStr="Password didn't match";

//home page strings
const String locationStr="Location";
const String searchCarBarStr="Search Car ...";
const String topBrandsStr="Top Brands";
const String popularCarStr="Popular Car";
const String seeAllStr="See All";
const String manualTypeStr="Manual";
const String automaticTypeStr="Auto";
const String rentalNowStr="Rental Now";


//car detail page strings
const String carDetailStr="Car Details";
const String aboutStr="About";
const String galleryStr="Gallery";
const String reviewStr="Review";
const String rentPartnerStr="Rent Partner";
const String ownerStr="Owner";
const String descriptionStr="Description";
const String rentNowStr="Rent Now";
const String priceStr="Price";
const String perDayStr="/ day";

//booking page str
const String bookingStr="Booking";
const String pickUpLocationStr="Pick-Up Location";
const String pickUpLocationValidationStr="Please enter pick-Up Location";
const String dropOffLocationStr="Drop-Off Location";
const String dropOffLocationValidationStr="Please enter drop-Off Location";
const String pickUpDateStr="Pick-Up Date";
const String selectDateStr="Select Date";
const String dateStr="Date";
const String pickUpDateValidationStr="Please select pick-Up Date";
const String pickUpTimeStr="Pick-Up Time";
const String selectTimeStr="Select Time";
const String timeStr="Time";
const String pickUpTimeValidationStr="Please select pick-Up Time";
// const String dropOffDateStr="Drop-Off Date";
// const String dropOffTimeStr="Drop-Off Time";
const String insuranceStr="Insurance";
const String insuranceCoveragesAgreementStr="By renting a car at Renter, you agree to the included insurance coverage for the selected car. ";

//billing page str
const String billingStr="Billing";
const String addressStr="Address";
const String countryStr="Country";
const String countryHintStr="Select Country";
const String genderStr="Gender";
const String genderHintStr="Select Gender";

//payment page str
const String paymentStr="Payment";
const String paypalStr="Paypal";
const String googlePayStr="Google Pay";
const String applePayStr="Apple Pay";

//review summary page str
const String reviewSummaryStr="Review Summary";
const String rentTypeStr="Rent Type";
const String additionalDriveStr="Additional Drive";
const String subTotalStr="Sub Total";
const String taxStr="Tax";
const String applyPromoCodeStr="Apply Promo Code";
const String applyNowStr="Apply Now";
const String changeStr="Change";
const String totalRentalPriceStr="Total Rental Price";
const String payPriceStr="Pay";

//e-reciept page str
const String eRecieptStr="E-Reciept";
const String carNameStr="Car";
const String seatsStr="Seats";
const String downloadStr="Download";

//chat page and profile page strings
const String chatStr="Chat";
const String searchChatStr="Search chat, people and more ...";
const String profileStr="Profile";
const String editProfileStr="Edit Profile";
const String viewCarDetailsStr="View Car Details";
const String licenseStr="License";
const String passportStr="Passport";
const String paymentMethodsStr="Payment Methods";
const String myBookingStr="My Booking";
const String settingStr="Settings";
const String logoutStr="Logout";
const String logoutConfirmStr="Do you really want to Logout?";

// add car form page
const String addCarDetailsStr="Add Car Details";
const String carNameLabelStr="Car Name";
const String carImageLabelStr="Car Image";
const String carLogoLabelStr="Car Logo";
const String carBrandLabelStr="Car Brand";
const String carTypeLabelStr="Car Type";
const String totalPassengerCapacityLabelStr="Passenger Capacity";
const String fuelCapacityLabelStr="Fuel Capacity";
const String priceLabelStr="Rent Price";

const String carNameHintStr="Enter Car Name";
const String carImageHintStr="Enter Car Image";
const String carLogoHintStr="Enter Car Logo";
const String carBrandHintStr="Enter Brand";
const String carTypeHintStr="Enter Car Type";
const String totalPassengerCapacityHintStr="Enter Passenger Capacity";
const String fuelCapacityHintStr="Enter Fuel Capacity";
const String priceHintStr="Enter Rent Price";

const String carNameValidateString = "Please enter car name";
const String carImageValidateString = "Please enter car image";
const String carLogoValidateString = "Please enter car logo";
const String carBrandValidateString = "Please enter car brand";
const String carTypeValidateString = "Please enter car type";
const String totalPassengerCapacityValidateString = "Please enter total passenger capacity";
const String fuelCapacityValidateString = "Please enter total fuel capacity";
const String priceValidateString = "Please enter rent price";
const String submitStr="Submit";
const String carDetailsAddedSuccessStr="Car Details Added successfully";
const String carDetailsAddedFailStr="Failed to add Car Details ";

//view car list screen
const String carListStr="Car List";
const String noCarFoudStr="No Car Found in the list";
const String deleteCarConfirmTitleStr="Delete Car";
const String deleteCarConfirmMessageStr="Do your really want to delete Car: ";
const String deleteCarSuccessMessageStr="Successfully deleted Car:";
const String deleteCarFailedStr="Failed to delete Car: ";
const String failedToFetchCar="Failed to fetch Car Details";

//dialogBox str
const String confirmStr="Confirm";
const String cancelStr="Cancel";
const String okStr="Ok";
const String yesStr="Yes";
const String noStr="No";

