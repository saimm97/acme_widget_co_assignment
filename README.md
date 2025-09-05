# Acme Widget Co. - Checkout System Prototype

## 📝 Overview

This repository contains a proof of concept for a basic sales checkout system designed for **Acme Widget Co**. The primary goal of this project is to demonstrate a simple yet flexible architecture for processing a shopping basket, calculating total costs, and applying various pricing rules such as special offers and delivery fees.

***

## 🏛️ Architectural Design

The system is built on a modular design that emphasizes extensibility and separation of concerns. The main components are:

* **Basket**: Serves as the primary entry point for users. It manages the items in a shopping session and orchestrates the final price calculation.
* **Catalogue**: Acts as a repository for all available products, holding their pricing and details.
* **Rules Engine**: A collection of configurable objects that apply specific business logic to the basket. This includes all logic for special promotions and delivery charge calculations, allowing new rules to be added without altering the core checkout flow.

To enhance testability and maintainability, the system uses **dependency injection** to supply the `Basket` with its required components (the `Catalogue` and the pricing `Rules`).

***

## 🛠️ System Requirements

To run this project, you will need the following software installed:

* **Ruby `3.3.9`**: The required version is specified in the `.ruby-version` file.
* **Bundler**: For managing Ruby gem dependencies. Install it via `gem install bundler`.

***

## 🚀 Execution Guide

Follow these steps to get the project running:

1.  **Install Dependencies**:
    ```shell
    bundle install
    ```
2.  **Run the Demo**:
    ```shell
    ruby main.rb
    ```
3.  **Run the Test Suite**:
    ```shell
    bundle exec rspec
    ```

***

## 🧠 Core Assumptions

The system operates on the following assumptions:

* The "buy one red widget, get the second half price" offer is applied to each pair of red widgets in the basket.
* Delivery charges are calculated based on the subtotal *after* all promotional discounts have been applied.