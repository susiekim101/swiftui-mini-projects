# SwiftUI Mini Projects

This repo contains small SwiftUI projects for learning and practice.

## Projects

| Project Name     | Description                      |
|------------------|----------------------------------|
| [WeSplit](./WeSplitApp) | Helps users split a bill with tip among a group |
| [Conversion](./ConversionApp) | Length unit converter |
| [GuessTheFlag](./GuessTheFlagApp) | Game to select the correct country flag's image |
| [RPSTraining](./RPSTrainingApp) | Brain training game to select either a winning or losing opion |
| [BetterRest](./BetterRest) | Calculates suggested sleep time depending on coffee intake |
| [WordScramble](./WordScrambleApp) | Score points by finding substrings of root word |

## Features
### WeSplit
- Input check amount, party size, and tip percentage
- Calculates total per person
- Uses SwiftUI components: '@State', 'Form', 'Picker'

### ConversionApp
- Accepts value input using numeric keyboard and desired length units
- Calculates converted value to 3 precision
- Uses SwiftUI components: '@State', 'Form', 'Picker', 'Measurement', and 'MeasurementFormatter'

### GuessTheFlag
- Shows a text of a country and user must select the correct image corresponding to the text
- Uses RadialGradients for background color, custom Views, alserts, and button logic

### RPS Training
- Users must select the RPS option that either wins or loses against the computer's randomized option

### BetterRest
- Input wake time, desire amount of sleep, and coffee intake and ouputs suggesed bed time
- Uses CoreML framework to train tabular regression model using curated dataset
- Uses 'DateComponents', 'DatePicker' and 'Stepper'

### WordScramble
- Generates a random word from standard dictionary and score points from finding valid substrings
- Higher points for inputting longer words
- Uses String manipulation with 'UIChecker', guard let, and 'Bundle'
  
## Acknowledgements
Projects in this repository were inspired by the [100 Days of SwiftUI] course (https://www.hackingwithswift.com/100/swiftui) by Paul Hudson.
