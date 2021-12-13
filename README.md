# iprocure_app

Introduction

Iprocure app is a flutter e-commerce that displays a list of products that have been added by users, hence various users can add the products which are displayed accordingly. It allows users to upload specific images for a product and also select which category it will grouped it. It offers easier navigation with the categories which allows one to narrow down the products through the filter and search features. The UI is very user-friendly allowing the user to access every element with ease. SQFLite was used to implement the local db and that caused importing the necessary plugin dependencies coming along with it to enable proper posting and retrievial of data.

Below are screenshots of the various pages of the applications:

This shows our list view page created using a scaffold container and performs future list called to the database helper to retrieve the list.
![image](https://github.com/megkl/iprocure_android_app_test/blob/main/assets/Screenshot_20211213-174117.jpg)

The above list is added using a create new product screen as shown below:
![image](https://github.com/megkl/iprocure_android_app_test/blob/main/assets/Screenshot_20211213-174229.jpg)

One is able to perform the search for products ash shown using SearchDelegate library implemented in the code:
![image](https://github.com/megkl/iprocure_android_app_test/blob/main/assets/Screenshot_20211213-174202.jpg)

Filtering of products by category is also done as shown:
![image](https://github.com/megkl/iprocure_android_app_test/blob/main/assets/Screenshot_20211213-174127.jpg)

UNIT TESTS

Implemented in the app_test file under test folder

Product List Feature

Requirement: The product list page should display a list of products from our local db. Each product should show at least its product name and cost

Actions: Mocking data models and classes by removing dependencies. Hardcode values for getproductList and not retrieve from database so that we can see how slow and unpredictable it will be:

