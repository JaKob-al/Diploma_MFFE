# Multiple Fundamental-Frequency Recognition in a Chord  
**Bachelor thesis algorithm** – University of Ljubljana, 2021  
Jakob Kobal – [jakob.kobal@gmail.com](mailto:jakob.kobal@gmail.com)

Iterative, model-based MATLAB algorithm for estimating the individual fundamental frequencies in a single-instrument polyphonic chord (no machine learning).

### Accuracy on real recordings (self-recorded, controlled environment)
- Digital organ: 100 chords, 94% full accuracy
- Digital piano: 100 chords, 75% full accuracy
- Accordion: 50 chords across two octaves, 98% accuracy (49/50 correct).

### How it works (high-level)
The algorithm begins by building a discretized spectral model for a single instrument. This involves recording an "alphabet" of individual pitches (isolated notes) and applying the Fast Fourier Transform (FFT) to capture their harmonic profiles—frequencies and relative amplitudes—accounting for deviations from ideal harmonicity in real instruments.

For chord recognition:

1.	The chord audio is windowed (e.g., Hann window) to reduce spectral leakage
2.	FFT generates the power spectrum.
3.	Starting with the lowest prominent peak (presumed to be the lowest fundamental), the algorithm matches it to the instrument model and subtracts its corresponding harmonics from the chord spectrum.
4.	It iteratively repeats this for the next lowest remaining peak, removing associated harmonics each time, until no significant peaks are left. Additional steps handle practical complexities: peak thresholding, normalizing harmonic values, adjustments for inharmonicity or slight frequency deviations.

This subtractive, model-based approach is deterministic and computationally efficient, processing chords in milliseconds without machine learning.

### Example chords used in testing
|----------|--------|-------------------|------------|
| F#3B4     | G5A5D6E6   | D#4E4F4C#5   | G4B4C5D#5F5  |
| C#4G4     | A#4B4D5F5  | D#4G4G#4C5   | A2E3C4E4A4   |
| C4C5      | C2E2G2C3   | D2A2C#3E3    | C3E3B3D4G4   |
| G3B4      | D#5G5A#5D6 | D3G#3A#3D#4  | E3E4A#4C#5E5 |

### Errors on digital organ test set (6 out of 100)
| Recognized       | Actual            | Difference |
|------------------|-------------------|------------|
| E2B2G3A3D4G4     | E2B2G3A3B3D4G4    | –1 tone    |
| G#2D#3G3C4       | G#2D#3G3C4F4      | –1         |
| A#3C#4E4G4A#4A#5 | A#3C#4E4G4A#4     | +1         |
| B3F#4B4B5        | B3F#4B4           | +1         |
| G#2D#3G#3C4F#4G#4C5 | G#2D#3G#3C4F#4C5 | –1      |
| G3D4G4G5         | G3D4G4            | +1         |

### Folder structure
- `/Demonstracije` – examples used for simple demonstrations in the thesis 
- `/Funkcije` – core functions  
- `/Harmonika`, `/Sintesajzer001`, `/Sintesajzer024` – instrument models with recordings  
- `prepoznajAkord.m` – main script (in each of the instrument models)

### Full thesis (66 pages, English summary included)
https://repozitorij.uni-lj.si/IzpisGradiva.php?id=134227&lang=eng

### Some Improvements & Possible Future Ideas
- Noise-proof → add denoising techniques
- Testing on a bigger dataset and on polyphonic acoustic instruments → 1,000 chords + reverb + room noise.
- Use of AI, data mining techniques → Build on algorithm's logic to get better accuracies 
- Multi-instrument → one model per instrument 
- Real-time → port to Python + PyAudio
- Expand the algorithm application to real music automatic transcription
- Explore parallels with the human perception
