from aiogram import Bot, Dispatcher, types
from aiogram.types import ReplyKeyboardMarkup, KeyboardButton, WebAppInfo
from aiogram.utils import executor

TOKEN = '7922512019:AAGA-ev8iHmyWTVB_V9AOkFSZWw0ilwDFtk'
ADMIN_ID = 1355844821
WEB_APP_URL = 'https://baldenko.github.io/ps-gift-shop/'

bot = Bot(token=TOKEN)
dp = Dispatcher(bot)

@dp.message_handler(commands=['start'])
async def start(message: types.Message):
    keyboard = ReplyKeyboardMarkup(resize_keyboard=True)
    web_app_btn = KeyboardButton('Открыть магазин', web_app=WebAppInfo(url=WEB_APP_URL))
    keyboard.add(web_app_btn)
    await message.answer("Привет! Добро пожаловать в магазин подарочных карт PlayStation.", reply_markup=keyboard)

@dp.message_handler(content_types=['web_app_data'])
async def web_app_data_handler(message: types.Message):
    data = message.web_app_data.data
    await bot.send_message(ADMIN_ID, f"Новый заказ: {data}\nОт пользователя: @{message.from_user.username or message.from_user.full_name}")
    await message.answer("Спасибо за заказ! Мы свяжемся с вами в ближайшее время.")

if __name__ == '__main__':
    executor.start_polling(dp)
