import cv2
import os

def resize_images(input_folder, output_folder, target_size):
    # 確保輸出資料夾存在
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # 取得資料夾內所有檔案
    files = os.listdir(input_folder)

    for file_name in files:
        # 檢查檔案是否為圖片
        if file_name.endswith(('.png', '.jpg', '.jpeg', '.gif')):
            # 構建輸入和輸出的檔案路徑
            input_path = os.path.join(input_folder, file_name)
            output_path = os.path.join(output_folder, file_name)

            # 載入圖片
            img = cv2.imread(input_path)

            # 調整大小
            resized_img = cv2.resize(img, target_size, interpolation=cv2.INTER_AREA)

            # 儲存調整大小後的圖片
            cv2.imwrite(output_path, resized_img)

if __name__ == "__main__":
    # 設定輸入和輸出資料夾以及目標大小
    input_folder = "D:/billy/dataset/Pallet/wood/images/val"
    output_folder = "D:/billy/dataset/Pallet/wood/images/val"
    target_size = (640, 480)  # 設定目標大小，以元組表示 (width, height)

    # 執行圖片調整大小的函式
    resize_images(input_folder, output_folder, target_size)