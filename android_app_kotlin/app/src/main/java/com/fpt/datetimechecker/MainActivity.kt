package com.fpt.datetimechecker

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import java.util.*

class MainActivity : AppCompatActivity() {
    
    private lateinit var dayInput: EditText
    private lateinit var monthInput: EditText
    private lateinit var yearInput: EditText
    private lateinit var checkButton: Button
    private lateinit var clearButton: Button
    private lateinit var resultText: TextView
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        initViews()
        setupListeners()
    }
    
    private fun initViews() {
        dayInput = findViewById(R.id.dayInput)
        monthInput = findViewById(R.id.monthInput)
        yearInput = findViewById(R.id.yearInput)
        checkButton = findViewById(R.id.checkButton)
        clearButton = findViewById(R.id.clearButton)
        resultText = findViewById(R.id.resultText)
    }
    
    private fun setupListeners() {
        checkButton.setOnClickListener {
            checkDateTime()
        }
        
        clearButton.setOnClickListener {
            clearInputs()
        }
    }
    
    private fun checkDateTime() {
        val dayStr = dayInput.text.toString().trim()
        val monthStr = monthInput.text.toString().trim()
        val yearStr = yearInput.text.toString().trim()
        
        // Check if fields are empty
        if (dayStr.isEmpty() || monthStr.isEmpty() || yearStr.isEmpty()) {
            showResult("Please fill all fields")
            return
        }
        
        // Check if inputs contain only numeric values and convert them
        val day: Int
        val month: Int
        val year: Int
        
                try {
            day = dayStr.toInt()
            Log.d("DateTimeChecker", "Parsed day: $day")
        } catch (e: NumberFormatException) {
            Log.e("DateTimeChecker", "Day parsing failed: '$dayStr'")
            showResult("Day must be a number (current input: '$dayStr')")
            return
        }

        try {
            month = monthStr.toInt()
            Log.d("DateTimeChecker", "Parsed month: $month")
        } catch (e: NumberFormatException) {
            Log.e("DateTimeChecker", "Month parsing failed: '$monthStr'")
            showResult("Month must be a number (current input: '$monthStr')")
            return
        }

        try {
            year = yearStr.toInt()
            Log.d("DateTimeChecker", "Parsed year: $year")
        } catch (e: NumberFormatException) {
            Log.e("DateTimeChecker", "Year parsing failed: '$yearStr'")
            showResult("Year must be a number (current input: '$yearStr')")
            return
        }
        
        // Validate ranges
        Log.d("DateTimeChecker", "Validating day: $day (should be 1-31)")
        if (day < 1 || day > 31) {
            Log.w("DateTimeChecker", "Day out of range: $day")
            showResult("Input data for Day is out of range")
            return
        }
        
        if (month < 1 || month > 12) {
            showResult("Input data for Month is out of range")
            return




        }
        
        if (year < 1000 || year > 3000) {
            showResult("Input data for Year is out of range")
            return
        }
        
        // Check for valid date combinations
        if (!isValidDate(day, month, year)) {
            showResult("$day/$month/$year is NOT correct date time !")
            return
        }
        
        // If we reach here, the date is valid
        val result = String.format("Valid Date: %02d/%02d/%04d", day, month, year)
        resultText.text = result
        resultText.visibility = View.VISIBLE
    }
    
    private fun isValidDate(day: Int, month: Int, year: Int): Boolean {
        try {
            val calendar = Calendar.getInstance()
            calendar.isLenient = false // This makes the calendar strict about invalid dates
            calendar.set(Calendar.YEAR, year)
            calendar.set(Calendar.MONTH, month - 1) // Calendar months are 0-based
            calendar.set(Calendar.DAY_OF_MONTH, day)
            
            // This will throw an exception if the date is invalid
            calendar.time
            return true
        } catch (e: Exception) {
            return false
        }
    }
    
    private fun clearInputs() {
        dayInput.setText("")
        monthInput.setText("")
        yearInput.setText("")
        resultText.visibility = View.GONE
        
        // Clear focus from all input fields
        dayInput.clearFocus()
        monthInput.clearFocus()
        yearInput.clearFocus()
    }

    private fun showResult(message: String) {
        resultText.text = message
        resultText.visibility = View.VISIBLE
    }

} 