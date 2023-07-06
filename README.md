
# Inteval Timer Repo (Demo)

This repository demonstrates one of the key aspects I encountered while building an Interval Timer.

Handling the timer's state when user leaves & comes back to the app. Without having the app continously ran in the background.

## Demo

![GIF](link)

When the user leaves and re-enters the app while the timer is active, the app displays the remaining time left and continues running the timer.
## Highlights
The way this was achieved involved a few highlevels.


- Remaining timer's duration (X)
- Time when user left the screen (Y)

```
    var timeLeft: Date?

    @objc func appMovedToBackground() {
        // assigning the current time upon moving out of the app
        timeLeft = Date()
        timer?.invalidate()
        
    }

```

- Time when user comes back to app (Z)
```
    func timeSince(whenPaused input: Date) -> Int {
        let currentDate = Date()
        let timeInterval = currentDate.timeIntervalSince(input)
        let accumulatedTime = Int(round(timeInterval))
        return accumulatedTime
    }
```


- X - (Y - Z) = "Start timer again with this"

```
    @objc func appMovedToForeGround() {
        if let timeLeft = timeUserLeft {
            countdownNumber = countdownNumber - timeSince(whenPaused: timeLeft)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerSpecifications), userInfo: nil, repeats: true)
        }
    }
```

- add Observers

```
    func addingObserver() {
        
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeGround), name: UIApplication.willEnterForegroundNotification, object: nil)
                
    }
```
