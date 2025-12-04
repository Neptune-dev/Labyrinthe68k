from PIL import Image
import sys

def image_to_text(image_path, output_path):
    """
    Convertit une image en fichier texte.
    Chaque pixel est représenté par 4 caractères ASCII:
    - Caractère 0 (NUL)
    - Valeur Blue (0-255)
    - Valeur Green (0-255)
    - Valeur Red (0-255)
    """
    try:
        # Ouvrir l'image
        img = Image.open(image_path)
        img = img.convert('RGB')
        
        width, height = img.size
        pixels = img.load()
        
        # Créer le fichier de sortie
        with open(output_path, 'wb') as f:
            for y in range(height):
                for x in range(width):
                    r, g, b = pixels[x, y]
                    
                    # Écrire 4 caractères: NUL + B + G + R
                    f.write(bytes([0, b, g, r]))
        
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
    output_path = sys.argv[2] if len(sys.argv) > 2 else image_path.rsplit('.', 1)[0] + '.tilesheet'  # Changer l'extension en .tilesheet
    
    image_to_text(image_path, output_path)