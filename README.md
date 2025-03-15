# HangmanGame

## Overview

This project is an interactive Hangman (Adam Asmaca) game developed using ASP.NET Web Forms and SQL Server. The game supports Turkish characters and features a time limit, visual feedback with animated images, sound effects, a scoring system, and a management panel for adding or removing words from the database.

## Features

- **Random Word Selection:**  
  The game randomly selects a word and its corresponding question from the database.

- **Keyboard Input:**  
  Players can use both an on-screen virtual keyboard and their physical keyboard (with Turkish character support) to guess letters.

- **Timer:**  
  Each round is timed for 30 seconds. If the timer runs out, the game ends.

- **Visual and Audio Effects:**  
  Wrong guesses reveal parts of the Hangman image step-by-step. Sound effects are played on button clicks, when a word is correctly guessed, and when the game is lost.

- **Scoring System:**  
  The score increases with every correctly guessed word.

- **Admin Panel:**  
  An admin panel (Admin.aspx) is provided for managing the word list. Administrators can view, add, and delete words. The word list is displayed within a scrollable panel that occupies 60% of the viewport height using Bootstrap.

- **Responsive Design:**  
  The project uses Bootstrap 5 for a modern, responsive layout.

- **Asynchronous Updates:**  
  Timer and other interactive events use an AJAX UpdatePanel to avoid full page reloads.

## Technologies Used

- **ASP.NET Web Forms (.NET Framework 4.6.2)**
- **SQL Server** (Database: HangmanGameDB, Table: dbo.Words)
- **Bootstrap 5**
- **JavaScript & jQuery**
- **CSS**
- **Font Awesome** (for icons)
- **AJAX UpdatePanel**

## Installation and Setup

### Project Setup

1. Open the solution file (.sln) in Visual Studio.
2. Ensure that the `Web.config` file is configured with the correct connection string (see below).
3. Place the `Sounds` folder (containing `Click.wav`, `GameOver.wav`, and `GameWin.wav`) and the `Images` folder (containing background and Hangman part images) in the project’s root directory.

### Database Setup

The project’s database content is provided as a `HangmanGameDB.bak` file included with the project. You can restore the database using SQL Server Management Studio (SSMS). To do this, open SSMS and connect to your SQL Server instance. Then, right-click on the **Databases** folder and select **Restore Database...**. In the restore dialog, choose the **Device** option and click the **...** button to add the `HangmanGameDB.bak` file. After reviewing the restore options, proceed with the database restoration.

#### Web.config Connection String

Once the database is restored, ensure that the connection string in your `Web.config` file reflects the correct database name and server settings. For example, your connection string should look like this:

```
<connectionStrings>
  <add name="HangmanDB"
       connectionString="Data Source=YOUR_SERVER_NAME;Initial Catalog=HangmanGameDB;Integrated Security=True;"
       providerName="System.Data.SqlClient"/>
</connectionStrings>
```

Replace `YOUR_SERVER_NAME` with the name of your SQL Server instance (for example, `localhost\SQLEXPRESS` or your server’s name). If you are using Windows Authentication, keep `Integrated Security=True`; if you are using SQL Server Authentication, adjust the connection string to include the appropriate username and password.

## Usage

1. Open the solution in Visual Studio.
2. Restore the database using the provided `HangmanGameDB.bak` file.
3. Run the project (F5). The application will open on the entry page where you can choose to start the game or access the admin panel.
4. In the **Game** section, play the Hangman game with interactive virtual and physical keyboard input.
5. In the **Admin** section, manage the word list by adding or deleting words.

## File Structure

```
HangmanGame/
├── Admin.aspx
├── Admin.aspx.cs
├── Game.aspx
├── Game.aspx.cs
├── Giris.aspx
├── Giris.aspx.cs
├── Web.config
├── Sounds/
│   ├── Click.wav
│   ├── GameOver.wav
│   └── GameWin.wav
├── Images/
│   ├── bg2.png
│   ├── part0.png
│   ├── part1.png
│   ├── part2.png
│   ├── part3.png
│   ├── part4.png
│   ├── part5.png
│   └── part6.png
└── README.md
```

---

**Note:** Due to GitHub's maximum file limit warning, only the necessary files have been uploaded. You only need to create an ASP.NET Web Forms project and add the corresponding files to your project folder. Also, please note that the project is built using ASP.NET Web Forms version 4.6.2.

---

This complete README.md content can be used as the main documentation for your GitHub repository.
