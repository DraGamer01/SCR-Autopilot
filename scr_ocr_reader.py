import pytesseract
import cv2
import json
import os
from screeninfo import get_monitors
from PIL import ImageGrab

output_path = os.path.join(os.path.expanduser("~"), "Desktop", "scr_ocr_output.json")

def detect_markers(image):
    text = pytesseract.image_to_string(image)
    car_stop = None
    for line in text.splitlines():
        if "CAR STOP" in line.upper():
            car_stop = line.strip()
            break
    return {
        "marker_detected": bool(car_stop),
        "marker_text": car_stop or "Unknown"
    }

def main():
    screen = get_monitors()[0]
    bbox = (screen.x, screen.y, screen.width, screen.height)
    img = ImageGrab.grab(bbox)
    img_cv = cv2.cvtColor(cv2.cvtColor(img, cv2.COLOR_RGB2BGR), cv2.COLOR_BGR2GRAY)
    data = detect_markers(img_cv)
    data.update({
        "next_stop": "Unknown",   # Este campo pode ser ajustado com OCR adicional
        "distance": "0.52 mi",    # Simulado por agora
        "carriages": 4            # Simulado por agora, substituir por leitor real
    })

    with open(output_path, "w") as f:
        json.dump(data, f)

if __name__ == "__main__":
    main()