<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <!-- Messenger Chat Widget Styles (Self-Contained & Guaranteed Styling) -->
    <style>
        /* Floating Messenger Toggle Icon (Fixed Bottom Right) */
        .btn-messenger-floating {
            position: fixed;
            bottom: 25px;
            right: 25px;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #0084ff 0%, #a033ff 50%, #ff5252 100%);
            color: #ffffff !important;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            box-shadow: 0 10px 28px rgba(0, 132, 255, 0.45);
            z-index: 99999;
            cursor: pointer;
            border: 2px solid rgba(255, 255, 255, 0.35);
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            text-decoration: none;
        }

        .btn-messenger-floating:hover {
            transform: scale(1.12) rotate(-6deg);
            box-shadow: 0 15px 35px rgba(160, 51, 255, 0.6);
        }

        .btn-messenger-floating .pulse-online-badge {
            position: absolute;
            top: 2px;
            right: 2px;
            width: 15px;
            height: 15px;
            background-color: #22c55e;
            border: 2px solid #0f172a;
            border-radius: 50%;
        }

        .btn-messenger-floating .messenger-tooltip {
            position: absolute;
            right: 72px;
            background: rgba(15, 23, 42, 0.95);
            color: #ffffff;
            padding: 0.45rem 0.9rem;
            border-radius: 10px;
            font-size: 0.825rem;
            font-weight: 600;
            white-space: nowrap;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.25s ease, transform 0.25s ease;
            transform: translateX(10px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.12);
        }

        .btn-messenger-floating:hover .messenger-tooltip {
            opacity: 1;
            transform: translateX(0);
        }

        /* Enclosed Messenger Chat Box Frame */
        .messenger-chat-box {
            position: fixed;
            bottom: 95px;
            right: 25px;
            width: 370px;
            max-width: calc(100vw - 35px);
            height: 510px;
            background: #0f172a;
            border: 1px solid rgba(255, 255, 255, 0.18);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.65);
            z-index: 100000;
            display: none; /* Only opens when Messenger icon is clicked */
            flex-direction: column;
            overflow: hidden;
            animation: messengerPop 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        @keyframes messengerPop {
            from { opacity: 0; transform: translateY(30px) scale(0.9); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .messenger-header {
            background: linear-gradient(135deg, #0084ff 0%, #1e1b4b 100%);
            padding: 1rem 1.25rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .messenger-header-info {
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .messenger-avatar {
            position: relative;
            width: 40px;
            height: 40px;
            background: #ffffff;
            color: #0084ff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .messenger-avatar .status-dot {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 11px;
            height: 11px;
            background-color: #22c55e;
            border: 2px solid #0f172a;
            border-radius: 50%;
        }

        .messenger-title {
            font-size: 0.95rem;
            font-weight: 700;
            color: #ffffff;
            margin: 0;
        }

        .messenger-subtext {
            font-size: 0.75rem;
            color: #818cf8;
            margin: 0;
        }

        .messenger-close-btn {
            background: rgba(255, 255, 255, 0.15);
            border: none;
            color: #ffffff;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background 0.2s ease;
        }

        .messenger-close-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .messenger-body {
            flex: 1;
            padding: 1.1rem;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 0.85rem;
            background: #090d16;
        }

        .chat-bubble {
            max-width: 85%;
            padding: 0.7rem 1rem;
            border-radius: 16px;
            font-size: 0.85rem;
            line-height: 1.45;
            word-wrap: break-word;
        }

        .bubble-shop {
            background: #1e293b;
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #f1f5f9;
            align-self: flex-start;
            border-bottom-left-radius: 4px;
        }

        .bubble-user {
            background: linear-gradient(135deg, #0084ff 0%, #0066cc 100%);
            color: #ffffff;
            align-self: flex-end;
            border-bottom-right-radius: 4px;
        }

        .messenger-quick-replies {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            margin-top: 0.4rem;
        }

        .quick-reply-chip {
            background: rgba(0, 132, 255, 0.12);
            border: 1px solid rgba(0, 132, 255, 0.35);
            color: #38bdf8;
            padding: 0.5rem 0.85rem;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 500;
            text-align: left;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            display: block;
        }

        .quick-reply-chip:hover {
            background: rgba(0, 132, 255, 0.3);
            border-color: #0084ff;
            color: #ffffff;
        }

        .messenger-footer {
            padding: 0.8rem 1rem;
            background: #0f172a;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            gap: 0.6rem;
            align-items: center;
        }

        .messenger-input {
            flex: 1;
            background: #1e293b;
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            padding: 0.5rem 1rem;
            color: #ffffff;
            font-size: 0.85rem;
        }

        .messenger-input:focus {
            outline: none;
            border-color: #0084ff;
        }

        .messenger-send-btn {
            background: linear-gradient(135deg, #0084ff, #a033ff);
            border: none;
            color: #ffffff;
            width: 38px;
            height: 38px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: transform 0.2s ease;
        }

        .messenger-send-btn:hover {
            transform: scale(1.08);
        }
    </style>

    <!-- Floating Messenger Toggle Icon (Góc Dưới Bên Phải) -->
    <div class="btn-messenger-floating" id="btnMessengerToggle" title="Chat tới VCLShop">
        <i class="bi bi-messenger"></i>
        <span class="pulse-online-badge"></span>
        <span class="messenger-tooltip">Chat tới Shop</span>
    </div>

    <!-- Enclosed Messenger Chat Box Frame -->
    <div class="messenger-chat-box" id="messengerChatBox">
        <!-- Header -->
        <div class="messenger-header">
            <div class="messenger-header-info">
                <div class="messenger-avatar">
                    <i class="bi bi-chat-dots-fill"></i>
                    <span class="status-dot"></span>
                </div>
                <div>
                    <h6 class="messenger-title">VCLShop Customer Care</h6>
                    <p class="messenger-subtext">🟢 Đang sẵn sàng tư vấn 24/7</p>
                </div>
            </div>
            <button type="button" class="messenger-close-btn" id="btnMessengerClose" title="Đóng box chat">&times;</button>
        </div>

        <!-- Body Messages -->
        <div class="messenger-body" id="messengerBody">
            <div class="chat-bubble bubble-shop">
                Xin chào! 👋 Cảm ơn bạn đã quan tâm VCLShop. Bạn cần chúng tôi hỗ trợ thông tin gì hôm nay?
            </div>

            <div class="messenger-quick-replies">
                <button type="button" class="quick-reply-chip" onclick="handleQuickReply('Tư vấn chọn mua Laptop & Thiết bị công nghệ')">
                    💻 Tư vấn mua Laptop & Smartphone
                </button>
                <button type="button" class="quick-reply-chip" onclick="handleQuickReply('Hướng dẫn áp mã ưu đãi VCLTECH2026')">
                    ⚡ Nhận mã giảm giá 500.000đ
                </button>
                <button type="button" class="quick-reply-chip" onclick="handleQuickReply('Chính sách bảo hành & Miễn phí vận chuyển')">
                    🚚 Chính sách giao hàng & Bảo hành
                </button>
                <a href="https://www.facebook.com/profile.php?id=61592204678747" target="_blank" rel="noopener noreferrer" class="quick-reply-chip text-decoration-none">
                    📘 Mở Chat Fanpage Facebook <i class="bi bi-box-arrow-up-right ms-1"></i>
                </a>
            </div>
        </div>

        <!-- Footer Input -->
        <div class="messenger-footer">
            <input type="text" class="messenger-input" id="messengerInput" placeholder="Nhập nội dung tin nhắn..." onkeypress="if(event.key === 'Enter') sendUserMessage();">
            <button type="button" class="messenger-send-btn" onclick="sendUserMessage()"><i class="bi bi-send-fill"></i></button>
        </div>
    </div>

    <!-- Premium Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-6 mb-4 mb-md-0">
                    <h5 class="text-white mb-3"><i class="bi bi-cpu-fill text-primary"></i> VCLShop</h5>
                    <p>Your one-stop destination for state-of-the-art consumer electronics. Quality and premium customer service guaranteed.</p>
                </div>
                <div class="col-md-3 mb-4 mb-md-0">
                    <h5 class="text-white mb-3">Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/home">Home Page</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart">Shopping Cart</a></li>
                        <li><a href="${pageContext.request.contextPath}/products">Admin Panel</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5 class="text-white mb-3">Support</h5>
                    <ul class="list-unstyled">
                        <li><a href="https://www.facebook.com/profile.php?id=61592204678747" target="_blank" rel="noopener noreferrer"><i class="bi bi-facebook text-primary me-1"></i> Fanpage Facebook</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms & Conditions</a></li>
                    </ul>
                </div>
            </div>
            <hr class="my-4 border-secondary">
            <div class="row align-items-center">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0">&copy; 2026 VCLShop. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end mt-2 mt-md-0">
                    <a href="https://www.facebook.com/profile.php?id=61592204678747" target="_blank" rel="noopener noreferrer" class="me-3 text-primary" title="Facebook Fanpage"><i class="bi bi-facebook fs-5"></i></a>
                    <a href="#" class="me-3"><i class="bi bi-twitter fs-5"></i></a>
                    <a href="#"><i class="bi bi-instagram fs-5"></i></a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Messenger Popup Logic Script -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const btnToggle = document.getElementById('btnMessengerToggle');
            const chatBox = document.getElementById('messengerChatBox');
            const btnClose = document.getElementById('btnMessengerClose');

            if(btnToggle && chatBox && btnClose) {
                // Toggle Chat Box strictly on Messenger Icon click
                btnToggle.addEventListener('click', function(e) {
                    e.stopPropagation();
                    const isDisplayed = (chatBox.style.display === 'flex');
                    chatBox.style.display = isDisplayed ? 'none' : 'flex';
                });

                // Close Chat Box on close button click
                btnClose.addEventListener('click', function(e) {
                    e.stopPropagation();
                    chatBox.style.display = 'none';
                });
            }
        });

        function handleQuickReply(text) {
            appendChatBubble(text, 'bubble-user');
            
            setTimeout(() => {
                let reply = "Cảm ơn bạn đã nhắn tin cho VCLShop! ";
                if (text.includes('Laptop')) {
                    reply += "Chúng tôi có đầy đủ mẫu Laptop MacBook, Asus, Dell chính hãng. Bạn hãy dùng bộ lọc sản phẩm để xem chi tiết nhé!";
                } else if (text.includes('VCLTECH2026')) {
                    reply += "Mã VCLTECH2026 áp dụng giảm ngay 500k cho đơn hàng từ 2.000.000đ khi tiến hành thanh toán!";
                } else if (text.includes('bảo hành')) {
                    reply += "Tất cả thiết bị tại VCLShop được miễn phí giao hàng toàn quốc và bảo hành 1 đổi 1 trong 24 tháng!";
                } else {
                    reply += "Tư vấn viên VCLShop đã nhận tin nhắn và sẽ phản hồi quý khách ngay!";
                }
                appendChatBubble(reply, 'bubble-shop');
            }, 600);
        }

        function sendUserMessage() {
            const input = document.getElementById('messengerInput');
            if(!input || !input.value.trim()) return;

            const text = input.value.trim();
            appendChatBubble(text, 'bubble-user');
            input.value = '';

            setTimeout(() => {
                const reply = "Cảm ơn bạn đã nhắn tin! Tư vấn viên VCLShop đang tiếp nhận và sẽ trả lời bạn trong giây lát. Hoặc bạn có thể click nút Mở Chat Fanpage để được chat trực tiếp qua Facebook Messenger!";
                appendChatBubble(reply, 'bubble-shop');
            }, 700);
        }

        function appendChatBubble(text, className) {
            const body = document.getElementById('messengerBody');
            if(!body) return;

            const bubble = document.createElement('div');
            bubble.className = 'chat-bubble ' + className;
            bubble.textContent = text;
            body.appendChild(bubble);
            body.scrollTop = body.scrollHeight;
        }
    </script>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
