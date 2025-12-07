from PIL import Image
import sys

def image_to_text(image_path, output_path):
    """
    Convertit une image en fichier binaire .tilesheet.
    Chaque pixel est représenté par 4 octets:
    - Octet 0 : flag (0 = opaque, 255 = transparent)
    - Octet 1 : Blue (0-255)
    - Octet 2 : Green (0-255)
    - Octet 3 : Red (0-255)
    Si l'image possède un canal alpha, un pixel est considéré transparent quand alpha == 0.
    """
    try:
        # Ouvrir l'image en RGBA pour conserver le canal alpha
        img = Image.open(image_path).convert('RGBA')
        
        width, height = img.size
        pixels = img.load()
        
        # Créer le fichier de sortie
        with open(output_path, 'wb') as f:
            for y in range(height):
                for x in range(width):
                    r, g, b, a = pixels[x, y]
                    
                    # Si le pixel est transparent (alpha == 0), flag = 255, sinon 0
                    flag = 255 if a == 0 else 0
                    
                    # Écrire 4 octets: flag + B + G + R
                    f.write(bytes([flag, b, g, r]))
        
        print(f"Conversion réussie: {output_path}")
        print(f"Dimensions: {width}x{height}")
        
    except FileNotFoundError:
        print(f"Erreur: Fichier image introuvable: {image_path}")
        sys.exit(1)
    except Exception as e:
        print(f"Erreur: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python tilesheetConverter.py <image_path> [output_path]")
        sys.exit(1)
    
    image_path = sys.argv[1]
    output_path = sys.argv[2] if len(sys.argv) > 2 else image_path.rsplit('.', 1)[0] + '.tilesheet'
    
    image_to_text(image_path, output_path)