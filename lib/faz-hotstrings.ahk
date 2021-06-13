;;;;;;;;;;;;;;;;;
;;; GIF LINKS ;;;
;;;;;;;;;;;;;;;;;

::gifidk::https://i.imgur.com/lwDdTgR.gifv
::gifmaybe::https://i.imgur.com/9Np0T66.gifv
::gifyes::https://i.imgur.com/ZX4jycy.gifv
::giflogic::https://i.imgur.com/Rp1LPJe.gifv
::gifwat::https://i.imgur.com/akqnxBY.gifv
::gifneymar::https://i.imgur.com/NKV5Jmc.gifv
::giftwice::https://i.imgur.com/8AJqJs4.gifv
::giftoto::https://i.imgur.com/k0ExBnW.gifv
::gifok::https://i.imgur.com/CryQijP.gifv
::gifsorry::https://i.imgur.com/UP4nrRY.gifv
::giftrue::https://i.imgur.com/4YF8Tag.gifv
::gifwhatever::https://i.imgur.com/8cfGt1g.gifv
::gifstop::https://i.imgur.com/7XugQOm.gifv
::gifout::https://i.imgur.com/D5KNCtV.gifv
::gifclassified::https://i.imgur.com/4eaIdeq.gifv
::gifoh::https://i.imgur.com/79tndRZ.gifv
::giflick::https://i.imgur.com/4Ir41O5.gifv
::gifmou::https://i.imgur.com/EnBxVfp.gifv
::gifcut::https://i.imgur.com/LKtb8Ht.gifv
::gifrepost::https://i.imgur.com/Jv1YEl0.gifv

;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;

:c*:]d::
FormatTime CurrentDateTime,, d/M/yy
Send %CurrentDateTime%
return

:c*:]D::
FormatTime CurrentDateTime,, d MMMM yyyy
Send %CurrentDateTime%
return

:*:]t::
FormatTime CurrentDateTime,, H:mm
Send %CurrentDateTime%
return

:?*:!?::‽
:*:.bn::☐
:*:.by::☑
:?*:1o2::½
:?*:1//2::½
:?*:1o4::¼
:?*:1//4::¼
:?*:3o4::¾
:?*:3//4::¾
:?*:+-::±
:?*:-+::±
:?*:+_::±
:?*:_+::±
:?*:e=>::≥
:?*:e=<::≤
:*:ohm::Ω
:*:rads2::ω
:*:.alpha::α
:*:.delta::δ
:*:.deltt::Δ
:*:.pi::π
:*:.rho::ρ
:*:.sigma::σ
:*:.tau::τ
:*:.phi::ϕ
:*:.zeta::ζ
:*:theta::θ
:*:.mu::μ
:*:.lambda::λ
:*:.gamma::γ
:*:etan::η
:*:.epsilon.::ε
:*:.int::∫
CapsLock & .::
if GetKeyState("Shift", "P")
	Send •
else
	Send ·
return
:?*:.deg::°
:?*C:dC::°C
:?*C:dF::°F
:?*C:.LA::←
:?*C:.RA::→
:?*C:.UA::↑
:?*C:.DA::↓
:*:.inf::∞
:*:.dia::Ø
:*:.summ::Σ
:*:thf::∴
:*:.appr::≈
CapsLock & -::
if GetKeyState("Shift", "P")
	Send —
else
	Send –
return
;CapsLock & 8::★
:*:.sqrt::√
:*:.sq::²
:*:.cu::³
:*:.neq::≠
:*:.cr::©
:?*:.rg::®
:?*:.tm::™
:?*:.tick::✓
:?*:.t1::✓
:?*:.t2::✔
:?*:.t3::🗸
:?*:.x1::⨯
:?*:.x2::✗
:?*:.x3::✘

:?*:/e/::é
:?*:\e\::è
:?*:..e::ë
:?*:^^e::ê
:?*:^e^::ê
:?*:..u::ü
:?*:.u.::ü
:?*:/o/::ø

:*:gbp*::£
:*:eur*::€
:*:jpy*::¥
:*?:cc*::¢
:?*:(c)::©
:?*:(r)::®
:?*:(tm)::™

:?*:.<3::♥

:?*:.sg.::🇸🇬
:?*:.us.::🇺🇸

:*?:`.` `.` `.::…

#Hotstring c1

GroupAdd Ignored, ahk_class Respawn001
GroupAdd Ignored, ahk_exe swtor.exe

#ifWinNotActive ahk_group Ignored

:*:@@::
Send %EmailAdd1%
return
:*:2@@::			; (2@@) Secondary email address
Send %EmailAdd2%
return
:*:3@@::			; (3@@) Third email address
Send %EmailAdd3%
return
:*:4@@::			; (4@@) Fourth email address
Send %EmailAdd4%
return

:*:add1::			; Physical addresses
Send %Address1%
return
:*:add2::
Send %Address2%
return
:*:add3::
Send %Address3%
return

#IfWinNotActive

#Hotstring C0

:*:monday::Monday
:*:tuesday::Tuesday
::tues::Tuesday
:*:wednesday::Wednesday
:*:thursday::Thursday
::thurs::Thursday
:*:friday::Friday
::fri::Friday
:*:saturday::Saturday
:*:sunday::Sunday
:*:otday::today
:*:january::January
:*:february::February
::feb::February
:*:april::April
:*:june::June
:*:july::July
:*:august::August
:*:september::September
::sep::September
:*:october::October
:*:november::November
::nov::November
:*:december::December
:*:thansk::thanks
:*:gonan::gonna
:*:giev::give
:*:tehy::they
:*:htey::they
::teh::the
:*:hte::the
:*:btu::but
:*:adn::and
::nad::and
:*:nda::and
:*:hwo::how
:*:knwo::know
:*:wiht::with
:*:ahve::have
:*:haev::have
:*:ahha::ahah
:*:haah::haha
:*:hhaa::haha
:*:btw::by the way
:*:tbh::to be honest
:*:yw::you're welcome
:*:wanan::wanna
:*:rnu::run
:*:jsut::just
:*:soem::some
:*:otehr::other
:*:otehrs::others
:*:anotehr::another
:*:everythign::everything
:*:soemthing::something
:*:soemthign::something
:*:somethign::something
:*:soemthings::something's
:*:soemthigns::something's
:*:somethigns::something's
:*:antyhing::anything
:*:antyhign::anything
:*:anythign::anything
:*:naything::anything
:*:anyoen::anyone
:*:anyoens::anyone's
:*:soemone::someone
:*:soemoen::someone
:*:somoene::someone
:*:soemones::someone's
:*:soemoens::someone's
:*:somoenes::someone's
:*:everyoen::everyone
:*:everyoens::everyone's
:*:relpy::reply
::ike::like
:*:liek::like
:*:liekly::likely
:*:unliek::unlike
:*:unliekly::unlikely
:*:itll::it'll
:*:itd::it'd
:*:thsi::this
:*:thsill::this'll
:*:thsid::this'd
:*:taht::that
:*:thta::that
:*:thats::that's
:*:thast::that's
:*:tahts::that's
:*:thtas::that's
:*:thatll::that'll
:*:tahtll::that'll
:*:thtall::that'll
::hwat::what
::whats::what's
::hwats::what's
::whatll::what'll
::hwatll::what'll
:*:whatd::what'd
:*:hwatd::what'd
::hwatever::whatever
:*:hwatevers::whatever's
:*:hwateverll::whatever'll
:*:oging::going
:*:goign::going
::sicne::since
::idk::I don't know
::ot::to
::gogo::go go
::dto::to
::relaly::really
::yuo::you
::oyu::you
::uyo::you
::ytou::you
::tyou::you
::yuor::your
::yoru::your
::yuro::your
::oyur::your
::oyru::your
::yuore::you're
::yorue::you're
::yuroe::you're
::oyure::you're
::oyrue::you're
::youd::you'd
::oyud::you'd
::uyod::you'd
::ytoud::you'd
::tyoud::you'd
::youll::you'll
::oyull::you'll
::uyoll::you'll
::ytoull::you'll
::tyoull::you'll
::youve::you've
::oyuve::you've
::uyove::you've
::ytouve::you've
::tyouve::you've
::wheres::where's
::whereve::where've
::youre::you're
::oyure::you're
::uyore::you're
::ytoure::you're
::tyoure::you're
::tiem::time
::tehre::there
::tehres::there's
::theres::there's
::everytiem::everytime
::ytd::yesterday
::godl::gold
::i'd::I'd
::i'm::I'm
::i'll::I'll
::ive::I've
:*:Ive::I've
:*:dont::don't
:*:wont::won't
::cant::can't
:*:doesnt::doesn't
:*:isnt::isn't
:*:wasnt::wasn't
:*:werent::weren't
:*:didnt::didn't
:*:arent::aren't
:*:shouldnt::shouldn't
:*:couldnt::couldn't
:*:wouldnt::wouldn't
:*:mustnt::mustn't
:*:musnt::mustn't
:*:hadnt::hadn't
:*:havent::haven't
:*:hasnt::hasn't
:*:shoudlnt::shouldn't
:*:coudlnt::couldn't
:*:woudlnt::wouldn't
:*:mutsnt::mustn't
:*:handt::hadn't
:*:havnet::haven't
:*:hanst::hasn't
:*:shoudltn::shouldn't
:*:coudltn::couldn't
:*:woudltn::wouldn't
:*:mutstn::mustn't
::gdi::god damn it
::fml::FML
::omw::on my way
::uhg::ugh
::yeha::yeah
:*:somethign::something
:*:thign::thing
:*:fiance::fiancé

; Ternary operator hotstring
:*:/tern::
    SendInput {Text}(Expression ? True : False)
    SendInput ^{Left 5}^+{Right}
return
