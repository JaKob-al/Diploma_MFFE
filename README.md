# Multiple Fundamental-Frequency Recognition in a Chord  
**Bachelor thesis algorithm** – University of Ljubljana, 2021  
Jakob Kobal – [jakob.kobal@gmail.com](mailto:jakob.kobal@gmail.com)

Iterative, model-based MATLAB algorithm for estimating the individual fundamental frequencies in a single-instrument polyphonic chord (no machine learning).

### Accuracy on real recordings (self-recorded, controlled environment)
- Digital organ: 100 chords, 94% full accuracy
- Digital piano: 100 chords, 75% full accuracy
- Accordion: 50 chords across two octaves, 98% accuracy (49/50 correct).

### How it works (high-level)
1. Build an instrument-specific spectral “alphabet” from isolated single notes (FFT → harmonic amplitudes).  
2. Take a chord recording → FFT → power spectrum.  
3. Iteratively:  
   - Find the lowest remaining peak → match to the fundamental in the model.  
   - Subtract that note’s entire harmonic series (scaled and shifted for slight inharmonicity).  
   - Repeat until no significant peaks remain.

Fast (milliseconds per chord), fully deterministic, and surprisingly robust on real acoustic instruments.

### Folder structure
- `/Demonstracije` – examples used for simple demonstrations in the thesis 
- `/Funkcije` – core functions  
- `/Harmonika`, `/Sintesajzer001`, `/Sintesajzer024` – instrument models with recordings  
- `prepoznajAkord.m` – main script (in each of the instrument models)

### Full thesis (66 pages, English summary included)
https://repozitorij.uni-lj.si/IzpisGradiva.php?id=134227&lang=eng

### Possible extensions
- Real-time Python port + PyAudio  
- Noise-robust preprocessing  
- Multi-instrument models  
- Larger datasets + room reverb  
- Direct comparison with human listeners  
- Integration into automatic transcription systems

Feel free to use or modify the code. Issues and pull requests welcome!
