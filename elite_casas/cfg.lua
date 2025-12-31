debug = true

JobName = "dynasty"
JobActivo = false -- si se pone en falso solo pueden crear propiedades los administradores (los comandos se registran en la 364 del sv.lua)
SoloAutosPersonales = true
NombreDePma = "pma-voice"
UseCustomInv = true 

invHouse = function(id, weight)
    -- [CORRECCIÓN] Limpiamos el ID. 
    -- Si el ID es "kuhkn_UIDVA", esto se quedará solo con "kuhkn" (lo que hay antes del guion bajo)
    local cleanId = string.match(id, "^([^_]+)") or id
    
    local stashId = 'house_' .. cleanId
    
    print("ID Original: " .. tostring(id)) -- Verás el largo
    print("ID Limpio para OX: " .. stashId) -- Verás el corto (el correcto)
    
    if exports.ox_inventory then
        exports.ox_inventory:openInventory('stash', stashId)
    else
        print("ERROR: ox_inventory no iniciado")
    end
end

Ints = {
    ["DeptoAlta1"] = {
        pos = vector3( -3819.19, -3001.25, 2001.8),
        hdg = 180.0
    },
    ["DeptoAlta2"] = {
        pos = vector3( -3819.1, -2001.0, 2001.8),
        hdg = 180.0
    },
    ["CasaAlta2"] = {
        pos = vector3( 3782.99, -995.51, 2007.21),
        hdg = 180.0
    },
    ["CasaBaja1"] = {
        pos = vector3( 3805.78, -2009.82, 1998.99),
        hdg = 0.0
    },
    ["CasaAlta1"] = {
        pos = vector3( 3795.47, 17.09, 2001.41),
        hdg = 180.0
    },
    ["CasaBaja2"] = {
        pos = vector3( 3803.81, -3014.89, 2000.8),
        hdg = 0.0
    },
   
}


if not IsDuplicityVersion() then -- CFG solo para el client-side

Shop = {
    {
        catname = "Sillones",
        props = {        
            {
                m = "v_corp_bk_chair1",
                price = 0
            },
            {
                m = "v_corp_facebeanbagc",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairarm_01",
                price = 0
            },  
            {
                m = "apa_mp_h_stn_chairarm_02",
                price = 0
            },  
            {
                m = "apa_mp_h_stn_chairarm_03",
                price = 0
            },  
            {
                m = "apa_mp_h_stn_chairarm_09",
                price = 0
            },  
            {
                m = "apa_mp_h_stn_chairarm_11",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairarm_12",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairarm_13",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairarm_23",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairarm_24",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairarm_25",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairarm_26",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairstool_12",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairstrip_02",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairstrip_03",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairstrip_04",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairstrip_05",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairstrip_06",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairstrip_07",
                price = 0
            },
            {
                m = "apa_mp_h_stn_chairstrip_08",
                price = 0
            },
            {
                m = "apa_mp_h_stn_foot_stool_01",
                price = 0
            },
            {
                m = "apa_mp_h_stn_foot_stool_02",
                price = 0
            },
            {
                m = "apa_mp_h_stn_sofa_daybed_01",
                price = 0
            },
            {
                m = "apa_mp_h_stn_sofa_daybed_02",
                price = 0
            },

            {
                m = "apa_mp_h_stn_sofa2seat_02",
                price = 0
            },
            {
                m = "apa_mp_h_stn_sofacorn_01",
                price = 0
            },
            {
                m = "apa_mp_h_stn_sofacorn_05",
                price = 0
            },
            {
                m = "apa_mp_h_stn_sofacorn_06",
                price = 0
            },
            {
                m = "xm_lab_sofa_01",
                price = 0
            },
            {
                m = "xm_lab_sofa_02",
                price = 0
            },
            {
                m = "ex_mp_h_off_sofa_003",
                price = 0
            },
            {
                m = "hei_heist_stn_sofa2seat_03",
                price = 0
            },
            {
                m = "hei_heist_stn_sofa3seat_01",
                price = 0
            },
            {
                m = "hei_heist_stn_sofa2seat_06",
                price = 0
            },
            {
                m = "hei_heist_stn_sofa3seat_02",
                price = 0
            },
            {
                m = "hei_heist_stn_sofa3seat_06",
                price = 0
            },
            {
                m = "imp_prop_impexp_sofabed_01a",
                price = 0
            },
            {
                m = "sum_mp_h_yacht_side_table_02",
                price = 0
            },
            {
                m = "v_res_fh_barcchair",
                price = 0
            },
            {
                m = "v_res_fh_benchshort",
                price = 0
            },
            {
                m = "v_res_fh_easychair",
                price = 0
            },
            {
                m = "v_res_fh_pouf",
                price = 0
            },
            {
                m = "v_res_fh_singleseat",
                price = 0
            },
            {
                m = "v_res_fh_sofa",
                price = 0
            },
            {
                m = "v_res_m_h_sofa_sml",
                price = 0
            },
            {
                m = "v_res_r_sofa",
                price = 0
            },
            {
                m = "prop_yacht_lounger",
                price = 0
            },
            {
                m = "apa_mp_h_stn_sofacorn_07",
                price = 0
            },

            {
                m = "apa_mp_h_stn_sofacorn_08",
                price = 0
            },

            {
                m = "apa_mp_h_stn_sofacorn_09",
                price = 0
            },

            {
                m = "apa_mp_h_stn_sofacorn_10",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_armchair_01",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_armchair_03",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_armchair_04",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_sofa_01",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_sofa_02",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_strip_chair_01",
                price = 0
            },
        }

    },
    {
        catname = "Arte",
        props = {        
            {
                m = "apa_mp_h_acc_artwalll_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_artwalll_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_artwalll_03",
                price = 0
            },
            {
                m = "apa_mp_h_acc_artwallm_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_artwallm_03",
                price = 0
            },
            {
                m = "apa_mp_h_acc_artwallm_04",
                price = 0
            },
            {
                m = "apa_p_h_acc_artwallm_01",
                price = 0
            },
            {
                m = "apa_p_h_acc_artwalll_01",
                price = 0
            },
            {
                m = "apa_p_h_acc_artwalll_02",
                price = 0
            },
            {
                m = "apa_p_h_acc_artwalll_03",
                price = 0
            },
            {
                m = "apa_p_h_acc_artwalll_04",
                price = 0
            },
            {
                m = "apa_p_h_acc_artwallm_03",
                price = 0
            },
            {
                m = "apa_p_h_acc_artwallm_04",
                price = 0
            },
            {
                m = "apa_p_h_acc_artwalls_03",
                price = 0
            },
            {
                m = "apa_p_h_acc_artwalls_04",
                price = 0
            },
            {
                m = "ex_mp_h_acc_artwalll_02",
                price = 0
            },
            {
                m = "ex_mp_h_acc_artwalll_03",
                price = 0
            },
            {
                m = "ex_mp_h_acc_artwallm_02",
                price = 0
            },
            {
                m = "ex_mp_h_acc_artwallm_03",
                price = 0
            },
            {
                m = "ex_mp_h_acc_artwallm_04",
                price = 0
            },
            {
                m = "ex_p_h_acc_artwalll_01",
                price = 0
            },
            {
                m = "ex_p_h_acc_artwalll_03",
                price = 0
            },
            {
                m = "ex_p_h_acc_artwallm_04",
                price = 0
            },
            {
                m = "hei_heist_acc_artwalll_01",
                price = 0
            },
            {
                m = "v_serv_metro_advertmid",
                price = 0
            },
            {
                m = "v_ilev_ra_doorsafe",
                price = 0
            },
            {
                m = "v_ilev_trev_pictureframebroken",
                price = 0
            },
            {
                m = "v_res_picture_frame",
                price = 0
            },
            {
                m = "prop_ceramic_jug_01",
                price = 0
            },
            {
                m = "prop_cs_frank_photo",
                price = 0
            },
            {
                m = "prop_cs_photoframe_01",
                price = 0
            },
            {
                m = "ch_prop_vault_painting_01a",
                price = 0
            },
            {
                m = "ch_prop_vault_painting_01b",
                price = 0
            },
            {
                m = "ch_prop_vault_painting_01c",
                price = 0
            },
            {
                m = "ch_prop_vault_painting_01d",
                price = 0
            },
            {
                m = "ch_prop_vault_painting_01e",
                price = 0
            },
            {
                m = "ch_prop_vault_painting_01f",
                price = 0
            },
            {
                m = "ch_prop_vault_painting_01g",
                price = 0
            },
            {
                m = "ch_prop_vault_painting_01h",
                price = 0
            },
            {
                m = "ch_prop_vault_painting_01i",
                price = 0
            },
            {
                m = "ch_prop_vault_painting_01j",
                price = 0
            },
        }

    },
    {
        catname = "Decoracion",
        props = {        
            {
                m = "apa_mp_h_acc_bottle_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_bottle_02",
                price = 0
            },
            {
                m = "prop_cs_leg_chain_01",
                price = 0
            },
            {
                m = "prop_cs_lipstick",
                price = 0
            },
            {
                m = "apa_mp_h_acc_bowl_ceramic_01",
                price = 0
            },
            {
                m = "hei_prop_pill_bag_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_box_trinket_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_box_trinket_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_candles_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_candles_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_candles_04",
                price = 0
            },
            {
                m = "apa_mp_h_acc_candles_05",
                price = 0
            },
            {
                m = "apa_mp_h_acc_candles_06",
                price = 0
            },
            {
                m = "apa_mp_h_acc_dec_plate_02",
                price = 0
            },
            {
                m = "v_res_fa_mag_motor",
                price = 0
            },
            {
                m = "v_res_fa_magtidy",
                price = 0
            },
            {
                m = "v_res_fa_potnoodle",
                price = 0
            },
            {
                m = "v_res_fa_shoebox2",
                price = 0
            },
            {
                m = "v_res_fa_shoebox1",
                price = 0
            },
            {
                m = "v_res_fa_shoebox3",
                price = 0
            },
            {
                m = "v_res_fa_shoebox4",
                price = 0
            },
            {
                m = "v_res_fa_tincorn",
                price = 0
            },
            {
                m = "v_res_fa_tintomsoup",
                price = 0
            },
            {
                m = "v_res_fa_yogamat002",
                price = 0
            },
            {
                m = "v_res_fashmag1",
                price = 0
            },
            {
                m = "v_res_fh_aftershavebox",
                price = 0
            },
            {
                m = "v_res_fh_bedsideclock",
                price = 0
            },
            {
                m = "v_res_fh_fruitbowl",
                price = 0
            },
            {
                m = "v_res_fh_guitaramp",
                price = 0
            },
            {
                m = "v_res_fh_kitnstool",
                price = 0
            },
            {
                m = "v_res_fh_speakerdock",
                price = 0
            },
            {
                m = "v_res_fh_tableplace",
                price = 0
            },
            {
                m = "v_res_fh_towelstack",
                price = 0
            },
            {
                m = "v_res_fh_towerfan",
                price = 0
            },
            {
                m = "v_res_glasspot",
                price = 0
            },
            {
                m = "v_res_investbook01",
                price = 0
            },
            {
                m = "v_res_investbook08",
                price = 0
            },
            {
                m = "v_res_j_magrack",
                price = 0
            },
            {
                m = "v_res_m_candlelrg",
                price = 0
            },
            {
                m = "v_res_m_candle",
                price = 0
            },
            {
                m = "v_res_m_horsefig",
                price = 0
            },
            {
                m = "v_res_m_kscales",
                price = 0
            },
            {
                m = "v_res_m_pot1",
                price = 0
            },
            {
                m = "v_res_mexball",
                price = 0
            },
            {
                m = "v_res_mlaundry",
                price = 0
            },
            {
                m = "v_res_monitorstand",
                price = 0
            },
            {
                m = "v_res_mp_ashtrayb",
                price = 0
            },
            {
                m = "v_res_mplinth",
                price = 0
            },
            {
                m = "v_res_r_coffpot",
                price = 0
            },
            {
                m = "v_res_r_figclown",
                price = 0
            },
            {
                m = "v_res_r_fighorse",
                price = 0
            },
            {
                m = "v_res_r_fighorsestnd",
                price = 0
            },
            {
                m = "v_res_r_figoblisk",
                price = 0
            },
            {
                m = "v_res_r_figpillar",
                price = 0
            },
            {
                m = "v_res_r_milkjug",
                price = 0
            },
            {
                m = "v_res_r_silvrtray",
                price = 0
            },
            {
                m = "v_res_r_sugarbowl",
                price = 0
            },
            {
                m = "prop_hottub2",
                price = 0
            },
            {
                m = "v_prop_floatcandle",
                price = 0
            },
            {
                m = "prop_w_me_hatchet",
                price = 0
            },
            {
                m = "prop_w_me_dagger",
                price = 0
            },
            {
                m = "prop_w_me_knife_01",
                price = 0
            },
            {
                m = "prop_syringe_01",
                price = 0
            },
            {
                m = "prop_sh_bong_01",
                price = 0
            },
            {
                m = "prop_passport_01",
                price = 0
            },
            {
                m = "prop_mem_candle_combo",
                price = 0
            },
            {
                m = "prop_fbi3_coffee_table",
                price = 0
            },
            {
                m = "prop_ing_crowbar",
                price = 0
            },
            {
                m = "prop_ld_fireaxe",
                price = 0
            },
            {
                m = "prop_cs_stock_book",
                price = 0
            },
            {
                m = "prop_cs_magazine",
                price = 0
            },
            {
                m = "prop_cs_documents_01",
                price = 0
            },
            {
                m = "ex_prop_tv_settop_remote",
                price = 0
            },
            {
                m = "prop_cs_dildo_01",
                price = 0
            },
            {
                m = "prop_cs_binder_01",
                price = 0
            },
            {
                m = "v_serv_bktmop_h",
                price = 0
            },
            {
                m = "v_serv_bs_spray",
                price = 0
            },
            {
                m = "v_serv_waste_bin1",
                price = 0
            },
            {
                m = "prop_detergent_01a",
                price = 0
            },
            {
                m = "prop_detergent_01b",
                price = 0
            },
            {
                m = "prop_inout_tray_01",
                price = 0
            },
            {
                m = "prop_folder_01",
                price = 0
            },
            {
                m = "prop_fib_ashtray_01",
                price = 0
            },
            {
                m = "prop_paper_box_02",
                price = 0
            },
            {
                m = "prop_paper_box_05",
                price = 0
            },
            {
                m = "v_res_cd",
                price = 0
            },
            {
                m = "v_serv_ct_binoculars",
                price = 0
            },
            {
                m = "v_serv_bs_razor",
                price = 0
            },
            {
                m = "v_serv_bs_scissors",
                price = 0
            },
            {
                m = "v_serv_bs_shvbrush",
                price = 0
            },
            {
                m = "v_res_desktidy",
                price = 0
            },
            {
                m = "v_res_cdstorage",
                price = 0
            },
            {
                m = "p_ld_am_ball_01",
                price = 0
            },
            {
                m = "p_ld_soc_ball_01",
                price = 0
            },
            {
                m = "prop_el_guitar_01",
                price = 0
            },
            {
                m = "prop_cs_heist_bag_02",
                price = 0
            },
            {
                m = "prop_big_bag_01",
                price = 0
            },
            {
                m = "prop_attache_case_01",
                price = 0
            },
            {
                m = "prop_fruit_basket",
                price = 0
            },
            {
                m = "prop_michael_backpack",
                price = 0
            },
            {
                m = "prop_mr_rasberryclean",
                price = 0
            },
            {
                m = "prop_novel_01",
                price = 0
            },
            {
                m = "prop_ld_suitcase_01",
                price = 0
            },
            {
                m = "prop_ld_case_01",
                price = 0
            },
            {
                m = "prop_ld_health_pack",
                price = 0
            },
            {
                m = "prop_security_case_01",
                price = 0
            },
            {
                m = "prop_stat_pack_01",
                price = 0
            },
            {
                m = "prop_tennis_bag_01",
                price = 0
            },
            {
                m = "p_cs_bbbat_01",
                price = 0
            },
            {
                m = "prop_dj_deck_01",
                price = 0
            },
            {
                m = "prop_cs_dildo_01",
                price = 0
            },
            {
                m = "p_ing_microphonel_01",
                price = 0
            },
            {
                m = "prop_ballistic_shield",
                price = 0
            },
            {
                m = "prop_armour_pickup",
                price = 0
            },
            {
                m = "prop_anim_cash_pile_02",
                price = 0
            },
            {
                m = "prop_anim_cash_pile_01",
                price = 0
            },
            {
                m = "prop_bodyarmour_03",
                price = 0
            },
            {
                m = "prop_busker_hat_01",
                price = 0
            },
            {
                m = "prop_cd_folder_pile2",
                price = 0
            },
            {
                m = "prop_cd_folder_pile1",
                price = 0
            },
            {
                m = "prop_cd_folder_pile3",
                price = 0
            },
            {
                m = "prop_cigar_pack_01",
                price = 0
            },
            {
                m = "prop_cliff_paper",
                price = 0
            },
            {
                m = "prop_cs_box_step",
                price = 0
            },
            {
                m = "prop_cs_ciggy_01",
                price = 0
            },
            {
                m = "prop_cs_cuffs_01",
                price = 0
            },
            {
                m = "prop_cs_duffel_01",
                price = 0
            },
            {
                m = "prop_cs_duffel_01b",
                price = 0
            },
            {
                m = "prop_cs_gunrack",
                price = 0
            },
            {
                m = "prop_cs_katana_01",
                price = 0
            },
            {
                m = "prop_cs_police_torch_02",
                price = 0
            },
            {
                m = "prop_idol_case_02",
                price = 0
            },
            {
                m = "prop_idol_case",
                price = 0
            },
            {
                m = "prop_gun_case_02",
                price = 0
            },
            {
                m = "prop_gun_case_01",
                price = 0
            },
            {
                m = "prop_franklin_dl",
                price = 0
            },
            {
                m = "prop_fib_badge",
                price = 0
            },
            {
                m = "prop_nigel_bag_pickup",
                price = 0
            },
            {
                m = "prop_scn_police_torch",
                price = 0
            },
            {
                m = "prop_proxy_hat_01",
                price = 0
            },
            {
                m = "prop_fountain2",
                price = 0
            },
            {
                m = "prop_garden_dreamcatch_01",
                price = 0
            },
            {
                m = "prop_gnome2",
                price = 0
            },
            {
                m = "prop_gnome1",
                price = 0
            },
            {
                m = "prop_tool_consaw",
                price = 0
            },
            {
                m = "prop_tool_box_04",
                price = 0
            },
            {
                m = "prop_tool_box_01",
                price = 0
            },
            {
                m = "prop_medstation_02",
                price = 0
            },
            {
                m = "prop_medstation_04",
                price = 0
            },
            {
                m = "prop_medstation_03",
                price = 0
            },
            {
                m = "prop_cs_bowie_knife",
                price = 0
            },
            {
                m = "prop_cs_bottle_opener",
                price = 0
            },
            {
                m = "v_ilev_exball_blue",
                price = 0
            },
            {
                m = "prop_glass_stack_09",
                price = 0
            },
            {
                m = "hei_prop_heist_thermite_case",
                price = 0
            },
            {
                m = "prop_carrier_bag_01",
                price = 0
            },
            {
                m = "ch_prop_swipe_card_01a",
                price = 0
            },
            {
                m = "ch_prop_swipe_card_01b",
                price = 0
            },
            {
                m = "ch_prop_swipe_card_01c",
                price = 0
            },
            {
                m = "ch_prop_swipe_card_01d",
                price = 0
            },
            {
                m = "vw_prop_vw_chip_carrier_01a",
                price = 0
            },
            {
                m = "vw_prop_casino_cards_01",
                price = 0
            },
            {
                m = "ng_proc_paper_news_quik",
                price = 0
            },
            {
                m = "v_res_filebox01",
                price = 0
            },

            {
                m = "apa_mp_h_acc_dec_sculpt_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_dec_sculpt_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_dec_sculpt_03",
                price = 0
            },
            {
                m = "apa_mp_h_acc_drink_tray_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_fruitbowl_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_fruitbowl_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_fruitbowl_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_jar_03",
                price = 0
            },
            {
                m = "apa_mp_h_acc_jar_04",
                price = 0
            },
            {
                m = "apa_mp_h_acc_pot_pouri_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_scent_sticks_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_tray_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_04",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_05",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_06",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_flowers_01",
                price = 0
            },

            {
                m = "apa_mp_h_acc_vase_flowers_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_flowers_03",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_flowers_04",
                price = 0
            },
        }

    },
    {
        catname = "Electrodomesticos",
        props = {
            {
                m = "apa_mp_h_acc_coffeemachine_01",
                price = 0
            },
            {
                m = "prop_coffee_mac_01",
                price = 0
            },
            {
                m = "prop_coffee_mac_02",
                price = 0
            },
            {
                m = "prop_food_bs_soda_01",
                price = 0
            },
            {
                m = "prop_food_bs_soda_02",
                price = 0
            },
            {
                m = "prop_griddle_02",
                price = 0
            },
            {
                m = "prop_juice_dispenser",
                price = 0
            },
            {
                m = "prop_microwave_1",
                price = 0
            },
            {
                m = "prop_watercooler_dark",
                price = 0
            },
            {
                m = "ba_prop_battle_bar_fridge_02",
                price = 0
            },
            {
                m = "prop_cs_ironing_board",
                price = 0
            },
            {
                m = "prop_cs_kettle_01",
                price = 0
            },
            {
                m = "v_corp_lidesk01",
                price = 0
            },
            {
                m = "v_corp_deskseta",
                price = 0
            },
            {
                m = "v_corp_desksetb",
                price = 0
            },
            {
                m = "v_corp_lidesk01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_phone_01",
                price = 0
            },            
        }
    },
    {
        catname = "Escritorios",
        props = {
            {
                m = "v_corp_deskseta",
                price = 0
            },
            {
                m = "v_corp_desksetb",
                price = 0
            },
            {
                m = "v_corp_lidesk01",
                price = 0
            },
            {
                m = "prop_office_desk_01",
                price = 0
            },
            {
                m = "xm_prop_base_staff_desk_02",
                price = 0
            },
            {
                m = "apa_mp_h_str_sideboards_02",
                price = 0
            },
        }
    },
    {
        catname = "Mesas",
        props = {
            {
                m = "apa_mp_h_din_table_01",
                price = 0
            },
            {
                m = "apa_mp_h_din_table_04",
                price = 0
            },
            {
                m = "prop_tv_cabinet_04",
                price = 0
            },
            {
                m = "prop_tv_cabinet_03",
                price = 0
            },
            {
                m = "prop_yacht_table_01",
                price = 0
            },
            {
                m = "apa_mp_h_din_table_05",
                price = 0
            },
            {
                m = "apa_mp_h_din_table_06",
                price = 0
            },
            {
                m = "apa_mp_h_din_table_11",
                price = 0
            },
            {
                m = "apa_mp_h_tab_coffee_05",
                price = 0
            },          
            {
                m = "apa_mp_h_tab_coffee_07",
                price = 0
            },     
            {
                m = "apa_mp_h_tab_coffee_08",
                price = 0
            },     
            {
                m = "apa_mp_h_tab_sidelrg_01",
                price = 0
            },     
            {
                m = "apa_mp_h_tab_sidelrg_02",
                price = 0
            },     
            {
                m = "apa_mp_h_tab_sidelrg_04",
                price = 0
            },     
            {
                m = "apa_mp_h_tab_sidelrg_07",
                price = 0
            },     
            {
                m = "apa_mp_h_yacht_coffee_table_01",
                price = 0
            },
            {
                m = "prop_protest_table_01",
                price = 0
            },
            {
                m = "prop_t_coffe_table_02",
                price = 0
            },
            {
                m = "ba_prop_int_edgy_table_01",
                price = 0
            },
            {
                m = "ba_prop_int_edgy_table_02",
                price = 0
            },
            {
                m = "ba_prop_int_glam_table",
                price = 0
            },
            {
                m = "bkr_prop_fakeid_table",
                price = 0
            },
            {
                m = "ex_prop_ex_console_table_01",
                price = 0
            },
            {
                m = "v_ind_dc_table",
                price = 0
            },
            {
                m = "v_ind_dc_desk03",
                price = 0
            },
            {
                m = "v_ind_rc_lowtable",
                price = 0
            },
            {
                m = "hei_prop_yah_table_01",
                price = 0
            },
            {
                m = "hei_prop_yah_table_02",
                price = 0
            },
            {
                m = "hei_prop_yah_table_03",
                price = 0
            },
            {
                m = "p_new_j_counter_02",
                price = 0
            },
            {
                m = "v_med_hosptable",
                price = 0
            },
            {
                m = "v_med_p_coffeetable",
                price = 0
            },
            {
                m = "prop_table_tennis",
                price = 0
            },
            {
                m = "ch_prop_table_casino_short_01a",
                price = 0
            },
            {
                m = "ch_prop_table_casino_tall_01a",
                price = 0
            },
            {
                m = "ch_prop_casino_blackjack_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_coffe_table_02",
                price = 0
            },
            {
                m = "ch_prop_casino_roulette_01a",
                price = 0
            },
            {
                m = "vw_prop_vw_table_01a",
                price = 0
            },
            {
                m = "v_res_fh_coftablea",
                price = 0
            },
            {
                m = "v_res_fh_coftableb",
                price = 0
            },
            {
                m = "v_res_fh_coftbldisp",
                price = 0
            },
            {
                m = "v_res_fh_diningtable",
                price = 0
            },
            {
                m = "v_res_j_lowtable",
                price = 0
            },
            {
                m = "v_res_m_stool",
                price = 0
            },
            {
                m = "v_res_msidetblemod",
                price = 0
            },
            {
                m = "prop_table_02",
                price = 0
            },
            {
                m = "prop_table_04",
                price = 0
            },
            {
                m = "prop_table_03b_cs",
                price = 0
            },
            {
                m = "prop_table_03b",
                price = 0
            },
            {
                m = "prop_table_05",
                price = 0
            },
            {
                m = "prop_table_06",
                price = 0
            },
            {
                m = "prop_table_08",
                price = 0
            },
            {
                m = "apa_mp_h_floorlamp_c",
                price = 0
            },
            {
                m = "apa_mp_h_floorlamp_c",
                price = 0
            },  
            {
                m = "apa_mp_h_yacht_coffee_table_02",
                price = 0
            },  
        }
    },
    {
        catname = "Lamparas",
        props = {
            {
                m = "apa_mp_h_floor_lamp_int_08",
                price = 0
            },
            {
                m = "xm_prop_base_tripod_lampb",
                price = 0
            },
            {
                m = "xm_prop_lab_tube_lampa_group6_p",
                price = 0
            },
            {
                m = "sum_mp_h_yacht_table_lamp_01",
                price = 0
            },
            {
                m = "sum_mp_h_yacht_floor_lamp_01",
                price = 0
            },
            {
                m = "sum_mp_h_yacht_table_lamp_02",
                price = 0
            },
            {
                m = "vw_prop_vw_lamp_01",
                price = 0
            },
            {
                m = "vw_prop_casino_art_lampf_01a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_lampm_01a",
                price = 0
            },
            {
                m = "sm_hanger_office_moden_lamp2",
                price = 0
            },
            {
                m = "v_res_fa_lamp1on",
                price = 0
            },
            {
                m = "v_res_fa_lamp2off",
                price = 0
            },
            {
                m = "xm_prop_x17_cctv_01a",
                price = 0
            },
            {
                m = "v_res_fh_lampa_on",
                price = 0
            },
            {
                m = "v_res_j_tablelamp1",
                price = 0
            },
            {
                m = "v_res_j_tablelamp2",
                price = 0
            },
            {
                m = "v_res_m_lampstand",
                price = 0
            },
            {
                m = "v_res_m_lampstand2",
                price = 0
            },
            {
                m = "v_res_m_lamptbl",
                price = 0
            },
            {
                m = "prop_garden_chimes_01",
                price = 0
            },
            {
                m = "prop_fragtest_cnst_06b",
                price = 0
            },
            {
                m = "apa_mp_h_floorlamp_c",
                price = 0
            },     
            {
                m = "apa_mp_h_lit_floorlamp_01",
                price = 0
            },
            {
                m = "apa_mp_h_lit_floorlamp_02",
                price = 0
            },
            {
                m = "apa_mp_h_lit_floorlamp_03",
                price = 0
            },
            {
                m = "apa_mp_h_lit_floorlamp_05",
                price = 0
            },     
            {
                m = "apa_mp_h_lit_floorlamp_06",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_floorlamp_10",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_floorlamp_13",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_floorlamp_17",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_floorlampnight_05",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_floorlampnight_07",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_floorlampnight_14",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lamptable_005",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lamptable_02",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lamptable_04",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lamptable_09",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lamptable_14",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lamptable_17",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lamptable_21",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lamptablenight_16",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lamptablenight_24",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lightpendant_01",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lightpendant_05",
                price = 0
            },  
            {
                m = "apa_mp_h_lit_lightpendant_05b",
                price = 0
            },  
            {
                m = "apa_mp_h_table_lamp_int_08",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_floor_lamp_01",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_table_lamp_01",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_table_lamp_02",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_table_lamp_03",
                price = 0
            },
            
        }
    },
    {
        catname = "Sillas",
        props = {
            {
                m = "v_med_p_deskchair",
                price = 0
            },
            {
                m = "v_serv_ct_chair01",
                price = 0
            },
            {
                m = "prop_off_chair_01",
                price = 0
            },
            {
                m = "prop_off_chair_03",
                price = 0
            },
            {
                m = "prop_off_chair_05",
                price = 0
            },
            {
                m = "prop_sol_chair",
                price = 0
            },
            {
                m = "v_corp_sidechair",
                price = 0
            },
            {
                m = "v_res_tre_chair",
                price = 0
            },
            {
                m = "v_corp_offchair",
                price = 0
            },  
            {
                m = "prop_wheelchair_01",
                price = 0
            },  
            {
                m = "hei_prop_yah_seat_01",
                price = 0
            },  
            {
                m = "hei_prop_heist_off_chair",
                price = 0
            },  
            {
                m = "prop_chair_04a",
                price = 0
            },  
            {
                m = "prop_chair_03",
                price = 0
            },
            {
                m = "prop_chair_07",
                price = 0
            },
            {
                m = "prop_table_04_chr",
                price = 0
            },
            {
                m = "ba_prop_int_glam_stool",
                price = 0
            },
            {
                m = "ch_prop_casino_chair_01c",
                price = 0
            },
            {
                m = "v_res_fa_chair01",
                price = 0
            },
            {
                m = "v_res_fa_chair02",
                price = 0
            },
            {
                m = "v_res_fh_dineeamesb",
                price = 0
            },
            {
                m = "v_res_fh_dineeamesc",
                price = 0
            },
            {
                m = "v_res_m_dinechair",
                price = 0
            },
            {
                m = "v_res_mbchair",
                price = 0
            },
            {
                m = "prop_direct_chair_01",
                price = 0
            },
            {
                m = "p_ilev_p_easychair_s",
                price = 0
            },
            {
                m = "prop_chair_04b",
                price = 0
            },
            {
                m = "prop_chair_05",
                price = 0
            },
            {
                m = "prop_table_01_chr_b",
                price = 0
            },
            {
                m = "prop_table_05_chr",
                price = 0
            },
            {
                m = "prop_table_06_chr",
                price = 0
            },
            {
                m = "v_corp_lngestool",
                price = 0
            },
            {
                m = "v_ilev_chair02_ped",
                price = 0
            },
            {
                m = "apa_mp_h_din_chair_04",
                price = 0
            },
            {
                m = "apa_mp_h_din_chair_08",
                price = 0
            },
            {
                m = "apa_mp_h_din_chair_09",
                price = 0
            },
            {
                m = "apa_mp_h_din_chair_12",
                price = 0
            },
            {
                m = "apa_mp_h_din_stool_04",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_barstool_01",
                price = 0
            },
        }
    
    },
    {
        catname = "Camas",
        props = {   
            {
                m = "v_res_lestersbed",
                price = 0
            },
            {
                m = "v_res_msonbed",
                price = 0
            },
            {
                m = "v_res_mdbed",
                price = 0
            },
            {
                m = "bkr_prop_biker_campbed_01",
                price = 0
            },
            {
                m = "v_res_tre_bed1_messy",
                price = 0
            },
            {
                m = "ex_prop_exec_bed_01",
                price = 0
            },
            {
                m = "v_res_tre_bed2",
                price = 0
            },
            {
                m = "imp_prop_impexp_sofabed_01a",
                price = 0
            },
            {
                m = "apa_mp_h_bed_double_09",
                price = 0
            },
            {
                m = "apa_mp_h_bed_double_08",
                price = 0
            },
            {
                m = "apa_mp_h_bed_wide_05",
                price = 0
            },
            {
                m = "apa_mp_h_bed_with_table_02",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_bed_01",
                price = 0
            },
            {
                m = "apa_mp_h_yacht_bed_02",
                price = 0
            },
        }
    },
    {
        catname = "Muros",
        props = {
            {
                m = "prop_ld_fragwall_01a",
                price = 0
            },
            {
                m = "prop_ld_fragwall_01b",
                price = 0
            },
            {
                m = "prop_ld_planter3c",
                price = 0
            },
        }
    },
    {
        catname = "Arte Diamond",
        props = {
            {
                m = "ex_prop_exec_award_diamond",
                price = 0
            },
            {
                m = "vw_prop_casino_art_statue_01a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_statue_02a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_statue_04a",
                price = 0
            },
            {
                m = "vw_prop_vw_pogo_gold_01a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_01a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_02a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_03a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_04a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_05a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_06a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_07a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_08a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_09a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_10a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_11a",
                price = 0
            },
            {
                m = "vw_prop_casino_art_car_12a",
                price = 0
            },
        }
    },
    {
        catname = "Plantas",
        props = {
            {
                m = "v_corp_potplant1",
                price = 0
            },
            {
                m = "apa_mp_h_acc_plant_palm_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_plant_tall_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_flowers_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_flowers_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_flowers_03",
                price = 0
            },
            {
                m = "p_int_jewel_plant_01",
                price = 0
            },
            {
                m = "p_int_jewel_plant_02",
                price = 0
            },
            {
                m = "prop_windowbox_a",
                price = 0
            },
            {
                m = "prop_windowbox_b",
                price = 0
            },
            {
                m = "xs3_prop_int_xmas_tree_01",
                price = 0
            },
            {
                m = "v_res_fa_plant01",
                price = 0
            },
            {
                m = "v_res_m_bananaplant",
                price = 0
            },
            {
                m = "v_res_m_palmstairs",
                price = 0
            },
            {
                m = "v_res_m_urn",
                price = 0
            },
            {
                m = "v_res_mflowers",
                price = 0
            },
            {
                m = "prop_peyote_lowland_02",
                price = 0
            },
            {
                m = "prop_fib_plant_01",
                price = 0
            },
            {
                m = "v_res_fh_flowersa",
                price = 0
            },
            {
                m = "apa_mp_h_acc_vase_flowers_04",
                price = 0
            }
        }
    },
    {
        catname = "Trofeos",
        props = {
            {
                m = "sum_prop_sum_trophy_qub3d_01a",
                price = 0
            },
            {
                m = "sum_prop_sum_trophy_ripped_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_trophy_strife_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_trophy_retro_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_trophy_racer_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_trophy_patriot_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_trophy_monkey_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_trophy_love_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_trophy_king_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_trophy_gunner_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_trophy_claw_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_trophy_cabs_01a",
                price = 0
            },
            {
                m = "ch_prop_ch_trophy_brawler_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_wrench_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_tower_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_telescope_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_spinner_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_shunt_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_rc_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_presents_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_pegasus_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_mines_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_imperator_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_goldbag_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_flipper_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_flags_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_firepit_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_drone_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_cup_01a",
                price = 0
            },
            {
                m = "ba_prop_battle_trophy_battler",
                price = 0
            },
            {
                m = "ba_prop_battle_trophy_dancer",
                price = 0
            },
            {
                m = "ba_prop_battle_trophy_no1",
                price = 0
            },
            {
                m = "xs_prop_arena_trophy_double_01a",
                price = 0
            },
            {
                m = "xs_prop_arena_trophy_double_01b",
                price = 0
            },
            {
                m = "xs_prop_arena_trophy_double_01c",
                price = 0
            },
            {
                m = "xs_prop_arena_trophy_single_01a",
                price = 0
            },
            {
                m = "xs_prop_arena_trophy_single_01b",
                price = 0
            },
            {
                m = "xs_prop_arena_trophy_single_01c",
                price = 0
            },
            {
                m = "xs_prop_trophy_bandito_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_carfire_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_carstack_01a",
                price = 0
            },
            {
                m = "xs_prop_trophy_champ_01a",
                price = 0
            }
        }
    },
    {
        catname = "Tecnologia",
        props = {
            {
                m = "v_serv_ct_monitor02",
                price = 0
            },
            {
                m = "v_serv_ct_monitor01",
                price = 0
            },
            {
                m = "prop_cs_server_drive",
                price = 0
            },
            {
                m = "v_serv_ct_monitor03",
                price = 0
            },
            {
                m = "v_serv_ct_monitor04",
                price = 0
            },
            {
                m = "v_serv_ct_monitor05",
                price = 0
            },
            {
                m = "v_serv_ct_monitor06",
                price = 0
            },
            {
                m = "v_serv_ct_monitor07",
                price = 0
            },
            {
                m = "prop_fax_01",
                price = 0
            },
            {
                m = "prop_fan_01",
                price = 0
            },
            {
                m = "prop_office_phone_tnt",
                price = 0
            },
            {
                m = "v_corp_potplant1",
                price = 0
            },
            {
                m = "prop_off_phone_01",
                price = 0
            },
            {
                m = "prop_printer_01",
                price = 0
            },
            {
                m = "prop_shredder_01",
                price = 0
            },
            {
                m = "prop_printer_02",
                price = 0
            },
            {
                m = "v_res_printer",
                price = 0
            },
            {
                m = "p_amb_lap_top_02",
                price = 0
            },
            {
                m = "p_amb_lap_top_01",
                price = 0
            },
            {
                m = "prop_ing_camera_01",
                price = 0
            },
            {
                m = "prop_pap_camera_01",
                price = 0
            },
            {
                m = "prop_t_telescope_01b",
                price = 0
            },
            {
                m = "prop_v_cam_01",
                price = 0
            },
            {
                m = "prop_exercisebike",
                price = 0
            },
            {
                m = "prop_console_01",
                price = 0
            },
            {
                m = "hei_prop_bank_cctv_01",
                price = 0
            },
            {
                m = "hei_prop_hst_laptop",
                price = 0
            },
            {
                m = "hei_prop_heist_pc_01",
                price = 0
            },
            {
                m = "hei_prop_hst_laptop",
                price = 0
            },
            {
                m = "prop_dyn_pc",
                price = 0
            },
            {
                m = "prop_ghettoblast_02",
                price = 0
            },
            {
                m = "prop_dyn_pc_02",
                price = 0
            },
            {
                m = "prop_el_tapeplayer_01",
                price = 0
            },
            {
                m = "prop_keyboard_01a",
                price = 0
            },
            {
                m = "prop_keyboard_01b",
                price = 0
            },
            {
                m = "prop_laptop_01a",
                price = 0
            },
            {
                m = "prop_laptop_02_closed",
                price = 0
            },
            {
                m = "prop_laptop_jimmy",
                price = 0
            },
            {
                m = "prop_monitor_01d",
                price = 0
            },
            {
                m = "prop_monitor_li",
                price = 0
            },
            {
                m = "prop_portable_hifi_01",
                price = 0
            },
            {
                m = "ba_prop_battle_club_computer_02",
                price = 0
            },
            {
                m = "ba_prop_battle_club_screen_03",
                price = 0
            },
            {
                m = "prop_tv_test",
                price = 0
            },
            {
                m = "v_med_cor_flatscreentv",
                price = 0
            },
            {
                m = "v_med_cor_tvstand",
                price = 0
            },
            {
                m = "prop_cctv_cont_03",
                price = 0
            },
            {
                m = "prop_cctv_cont_05",
                price = 0
            },
            {
                m = "prop_cctv_unit_03",
                price = 0
            },
            {
                m = "prop_cctv_unit_05",
                price = 0
            },
            {
                m = "prop_cs_tv_stand",
                price = 0
            },
            {
                m = "prop_michaels_credit_tv",
                price = 0
            },
            {
                m = "prop_trev_tv_01",
                price = 0
            },
            {
                m = "prop_tv_01",
                price = 0
            },
            {
                m = "prop_tv_03",
                price = 0
            },
            {
                m = "prop_tv_05",
                price = 0
            },
            {
                m = "prop_dest_cctv_03b",
                price = 0
            },
            {
                m = "prop_tv_02",
                price = 0
            },
            {
                m = "prop_tv_04",
                price = 0
            },
            {
                m = "prop_tv_06",
                price = 0
            },
            {
                m = "prop_tv_07",
                price = 0
            },
            {
                m = "prop_tv_flat_01",
                price = 0
            },
            {
                m = "prop_tv_flat_02",
                price = 0
            },
            {
                m = "prop_tv_flat_02b",
                price = 0
            },
            {
                m = "prop_tv_flat_03",
                price = 0
            },
            {
                m = "prop_cctv_cam_01a",
                price = 0
            },
            {
                m = "xm_prop_x17_tv_ceiling_01",
                price = 0
            },
            {
                m = "prop_cs_tablet",
                price = 0
            },
            {
                m = "v_res_fa_fan",
                price = 0
            },
            {
                m = "v_res_j_tvstand",
                price = 0
            },
            {
                m = "v_res_lest_monitor",
                price = 0
            },
            {
                m = "prop_boombox_01",
                price = 0
            },
            {
                m = "prop_controller_01",
                price = 0
            },
            {
                m = "prop_cs_cctv",
                price = 0
            },
            {
                m = "prop_cs_hand_radio",
                price = 0
            },
            {
                m = "prop_cs_walkie_talkie",
                price = 0
            },
            {
                m = "prop_ecg_01",
                price = 0
            },
            {
                m = "prop_mp3_dock",
                price = 0
            },
            {
                m = "prop_sewing_machine",
                price = 0
            },
            {
                m = "prop_table_mic_01",
                price = 0
            },
            {
                m = "prop_tapeplayer_01",
                price = 0
            },
            {
                m = "p_tv_cam_02_s",
                price = 0
            },
            {
                m = "prop_outdoor_fan_01",
                price = 0
            },
            {
                m = "v_ret_gc_fax",
                price = 0
            }
        }
    },
    {
        catname = "Comida",
        props = {
      
            {
                m = "prop_food_bs_bag_01",
                price = 0
            },
            {
                m = "p_amb_coffeecup_01",
                price = 0
            },
            {
                m = "prop_food_bs_burg3",
                price = 0
            },
            {
                m = "prop_cs_hotdog_01",
                price = 0
            },
            {
                m = "prop_cs_bowl_01",
                price = 0
            },
            {
                m = "prop_food_bs_juice02",
                price = 0
            },
            {
                m = "prop_food_ketchup",
                price = 0
            },
            {
                m = "prop_food_sugarjar",
                price = 0
            },
            {
                m = "v_ret_247_choptom",
                price = 0
            },
            {
                m = "v_ret_247_bread1",
                price = 0
            },
            {
                m = "v_ret_247_ketchup1",
                price = 0
            },
            {
                m = "v_ret_247_noodle3",
                price = 0
            },
            {
                m = "v_ret_ml_beerben1",
                price = 0
            },
            {
                m = "v_ret_ml_beerdus",
                price = 0
            },
            {
                m = "v_ret_ml_sweet1",
                price = 0
            },
            {
                m = "v_ret_ml_sweet7",
                price = 0
            },
            {
                m = "prop_beer_pride",
                price = 0
            },
            {
                m = "ba_prop_battle_champ_open_02",
                price = 0
            },
            {
                m = "ba_prop_battle_champ_closed_02",
                price = 0
            },
            {
                m = "ba_prop_battle_ice_bucket",
                price = 0
            },
            {
                m = "ba_prop_club_champset",
                price = 0
            },
            {
                m = "v_res_fa_ketchup",
                price = 0
            },
            {
                m = "v_res_m_woodbowl",
                price = 0
            },
            {
                m = "v_res_m_wbowl_move",
                price = 0
            },
            {
                m = "v_res_mbowlornate",
                price = 0
            },
            {
                m = "p_whiskey_notop",
                price = 0
            },
            {
                m = "prop_beer_box_01",
                price = 0
            },
            {
                m = "prop_coffee_cup_trailer",
                price = 0
            },
            {
                m = "prop_cs_burger_01",
                price = 0
            },
            {
                m = "prop_cs_champ_flute",
                price = 0
            },
            {
                m = "prop_cs_fork",
                price = 0
            },
            {
                m = "prop_cs_plate_01",
                price = 0
            },
            {
                m = "prop_peanut_bowl_01",
                price = 0
            },
            {
                m = "prop_taco_01",
                price = 0
            },
            {
                m = "p_tumbler_01_trev_s",
                price = 0
            }    
        }
    },
    {
        catname = "Alfombras",
        props = {
      
            {
                m = "apa_mp_h_acc_rugwooll_04",
                price = 0
            },
            {
                m = "apa_mp_h_acc_rugwoolm_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_rugwoolm_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_rugwoolm_03",
                price = 0
            },
            {
                m = "apa_mp_h_acc_rugwoolm_04",
                price = 0
            },
            {
                m = "apa_mp_h_acc_rugwools_01",
                price = 0
            },
            {
                m = "apa_mp_h_acc_rugwools_03",
                price = 0
            }    
        }
    },
    {
        catname = "TV con Mueble",
        props = {
            {
                m = "apa_mp_h_str_avunitl_01_b",
                price = 0
            },
            {
                m = "apa_mp_h_str_avunitl_04",
                price = 0
            },
            {
                m = "apa_mp_h_str_avunitm_01",
                price = 0
            },
            {
                m = "apa_mp_h_str_avunitl_04",
                price = 0
            },
            {
                m = "apa_mp_h_str_avunitm_01",
                price = 0
            },
            {
                m = "apa_mp_h_str_avunitm_03",
                price = 0
            },
            {
                m = "apa_mp_h_str_avunits_01",
                price = 0
            },
            {
                m = "apa_mp_h_str_avunits_04",
                price = 0
            },
            --[[{
                m = "adg",
                price = 0
            },
            {
                m = "adg",
                price = 0
            },
            {
                m = "adg",
                price = 0
            },
            {
                m = "adg",
                price = 0
            },
            {
                m = "adg",
                price = 0
            },
            {
                m = "adg",
                price = 0
            },
            {
                m = "adg",
                price = 0
            },]]

        }
    },
    {
        catname = "Muebles",
        props = {
            {
                m = "apa_mp_h_str_shelffloorm_02",
                price = 0
            },
            {
                m = "apa_mp_h_str_shelffreel_01",
                price = 0
            },
            {
                m = "apa_mp_h_str_sideboardl_11",
                price = 0
            },
            {
                m = "v_res_fh_sidebrddine",
                price = 0
            },
            {
                m = "v_res_fh_sidebrdlngb",
                price = 0
            },
            {
                m = "v_res_m_armoire",
                price = 0
            },
            {
                m = "v_res_m_dinetble_replace",
                price = 0
            },
            {
                m = "v_res_mconsolemod",
                price = 0
            },
            {
                m = "v_res_mddresser",
                price = 0
            },
            {
                m = "v_res_mcupboard",
                price = 0
            },
            {
                m = "v_res_m_console",
                price = 0
            },
            {
                m = "v_res_m_h_console",
                price = 0
            },
            {
                m = "prop_office_desk_01",
                price = 0
            },
            {
                m = "prop_cabinet_01b",
                price = 0
            },
            {
                m = "prop_t_sofa_02",
                price = 0
            },
            {
                m = "p_yacht_sofa_01_s",
                price = 0
            },
            {
                m = "p_yacht_chair_01_s",
                price = 0
            },
            {
                m = "apa_mp_h_bed_table_wide_12",
                price = 0
            },
            {
                m = "hei_heist_bed_table_dble_04",
                price = 0
            },
            {
                m = "apa_mp_h_bed_chestdrawer_02",
                price = 0
            },
            {
                m = "apa_mp_h_str_shelfwallm_01",
                price = 0
            },
            {
                m = "apa_mp_h_str_sideboardl_06",
                price = 0
            },
            {
                m = "apa_mp_h_str_sideboardl_09",
                price = 0
            },
            {
                m = "apa_mp_h_str_sideboardl_11",
                price = 0
            },
            {
                m = "apa_mp_h_str_sideboardl_13",
                price = 0
            },
            {
                m = "apa_mp_h_str_sideboardl_14",
                price = 0
            },
            {
                m = "apa_mp_h_str_sideboardm_02",
                price = 0
            },
            {
                m = "apa_mp_h_str_sideboardm_03",
                price = 0
            },
            {
                m = "apa_mp_h_str_sideboards_01",
                price = 0
            },
        }
    },
    {
        catname = "Carteles de Neon",
        props = {
      
            {
                m = "prop_beer_neon_01",
                price = 0
            },
            {
                m = "prop_beer_neon_02",
                price = 0
            },
            {
                m = "prop_beer_neon_03",
                price = 0
            },
            {
                m = "prop_beer_neon_04",
                price = 0
            },
            {
                m = "ba_prop_sign_galaxy",
                price = 0
            },
            {
                m = "ba_prop_sign_maison",
                price = 0
            },
            {
                m = "ba_prop_sign_palace",
                price = 0
            },
            {
                m = "ba_prop_sign_studio",
                price = 0
            },
            {
                m = "ba_prop_sign_tonys",
                price = 0
            },
            {
                m = "apa_mp_h_acc_rugwools_01",
                price = 0
            },
            {
                m = "prop_cherenneon",
                price = 0
            },
            {
                m = "prop_ragganeon",
                price = 0
            },
            {
                m = "apa_mp_h_acc_rugwools_03",
                price = 0
            }    
        }
    },
    {
        catname = "Music / DJ",
        props = {
      
            {
                m = "stt_prop_speakerstack_01a",
                price = 0
            },
            {
                m = "prop_dj_deck_02",
                price = 0
            },
            {
                m = "v_club_vu_djbag",
                price = 0
            },
            {
                m = "ba_prop_battle_club_speaker_large",
                price = 0
            },
            {
                m = "ba_prop_battle_club_speaker_med",
                price = 0
            },
            {
                m = "ba_prop_battle_club_speaker_small",
                price = 0
            },
            {
                m = "ba_prop_battle_club_speaker_dj",
                price = 0
            },
            {
                m = "ba_prop_battle_club_speaker_array",
                price = 0
            },
            {
                m = "ba_prop_battle_dj_deck_01a",
                price = 0
            },
            {
                m = "ba_prop_battle_dj_stand",
                price = 0
            },
            {
                m = "ba_prop_battle_dj_mixer_01d",
                price = 0
            },
            {
                m = "ba_prop_battle_dj_mixer_01e",
                price = 0
            },
            {
                m = "ba_prop_battle_dj_mixer_01c",
                price = 0
            },
            {
                m = "ba_prop_battle_dj_mixer_01a",
                price = 0
            },
            {
                m = "ba_prop_battle_headphones_dj",
                price = 0
            },
            {
                m = "ba_prop_club_smoke_machine",
                price = 0
            },   
        }
    },
    {
        catname = "Joyeria",
        props = {
      
            {
                m = "prop_j_disptray_03",
                price = 0
            },
            {
                m = "prop_j_disptray_04",
                price = 0
            },
            {
                m = "prop_jewel_pickup_new_01",
                price = 0
            },
            {
                m = "prop_jewel_04b",
                price = 0
            },
            {
                m = "prop_jewel_03b",
                price = 0
            },
            {
                m = "prop_jewel_02c",
                price = 0
            },
            {
                m = "prop_jewel_02b",
                price = 0
            },
            {
                m = "prop_jewel_02a",
                price = 0
            },
            {
                m = "prop_j_neck_disp_01",
                price = 0
            },
            {
                m = "prop_j_neck_disp_02",
                price = 0
            },
            {
                m = "apa_mp_h_acc_rugwools_03",
                price = 0
            }    
        }
    },
    {
        catname = "Heladera",
        props = {
      
            {
                m = "v_ilev_mm_fridgeint",
                price = 0
            },
            {
                m = "v_ilev_mm_fridge_l",
                price = 0
            },
            {
                m = "v_ilev_mm_fridge_r",
                price = 0
            }    
        }
    },
    {
        catname = "Baño",
        props = {
      
            {
                m = "prop_toilet_soap_02",
                price = 0
            },
            {
                m = "prop_toothb_cup_01",
                price = 0
            },
            {
                m = "prop_toothbrush_01",
                price = 0
            },
            {
                m = "prop_toothpaste_01",
                price = 0
            },
            {
                m = "prop_towel_01",
                price = 0
            },
            {
                m = "prop_towel_rail_01",
                price = 0
            },
            {
                m = "prop_towel_rail_02",
                price = 0
            },
            {
                m = "prop_w_fountain_01",
                price = 0
            },
            {
                m = "v_res_mbath",
                price = 0
            }    
        }
    },
    {
        catname = "Cosas Varias",
        props = {
      
            {
                m = "prop_gas_grenade",
                price = 0
            },
            {
                m = "prop_gas_mask_hang_01bb",
                price = 0
            },
            {
                m = "hei_prop_heist_weed_block_01b",
                price = 0
            },
            {
                m = "hei_prop_heist_weed_block_01",
                price = 0
            },
            {
                m = "hei_prop_heist_weed_pallet",
                price = 0
            },
            {
                m = "hei_prop_heist_weed_pallet_02",
                price = 0
            },
            {
                m = "p_cs_papers_01",
                price = 0
            },
            {
                m = "prop_cash_case_01",
                price = 0
            },
            {
                m = "prop_cash_case_02",
                price = 0
            },
            {
                m = "prop_cigar_01",
                price = 0
            },
            {
                m = "prop_cigar_03",
                price = 0
            },
            {
                m = "prop_cs_pills",
                price = 0
            },
            {
                m = "prop_meth_bag_01",
                price = 0
            },
            {
                m = "prop_riot_shield",
                price = 0
            },
            {
                m = "prop_sgun_casing",
                price = 0
            },
            {
                m = "prop_tea_trolly",
                price = 0
            },
            {
                m = "prop_weed_bottle",
                price = 0
            },
            {
                m = "prop_weed_tub_01",
                price = 0
            },
            {
                m = "prop_box_ammo01a",
                price = 0
            },
            {
                m = "prop_box_ammo07b",
                price = 0
            },
            {
                m = "prop_box_guncase_02a",
                price = 0
            },
            {
                m = "prop_box_guncase_03a",
                price = 0
            },
            {
                m = "bkr_prop_coke_powder_02",
                price = 0
            },
            {
                m = "bkr_prop_coke_metalbowl_02",
                price = 0
            },
            {
                m = "ba_prop_battle_coke_block_01a",
                price = 0
            },
            {
                m = "hei_prop_heist_trevor_case",
                price = 0
            },
            {
                m = "vw_prop_vw_ped_business_01a",
                price = 0
            }    
        }
    },
    {
        catname = "Almacenamiento",
        props = {
            {
                m = "v_res_tre_storageunit",
                price = 3000,
                w = 20,
                fp = true
            },
            {
                m = "v_res_jewelbox",
                price = 400,
                w = 5,
                fp = true
            },
            {
                m = "v_res_tre_storagebox",
                price = 2500,
                w = 50,
                fp = true
            },
            {
                m = "v_med_p_tidybox",
                price = 1300,
                w = 25,
                fp = true
            },
            {
                m = "hei_prop_heist_deposit_box",
                price = 250,
                w = 5,
                fp = true
            },
            {
                m = "hei_prop_heist_wooden_box",
                price = 2000,
                w = 40,
                fp = true
            },
            {
                m = "prop_box_ammo03a",
                price = 2500,
                w = 50,
                fp = true
            },
            {
                m = "p_v_43_safe_s",
                price = 4000,
                w = 75,
                fp = true
            },
            {
                m = "ch_prop_mil_crate_02b",
                price = 250,
                w = 50,
                fp = true
            },
            {
                m = "v_res_fh_crateclosed",
                price = 2500,
                w = 50,
                fp = true
            },

            {
                m = "prop_mil_crate_01",
                price = 5000,
                w = 100,
                fp = true
            },


        }
    }
}

-- ===========================================
--  NO TOCAR / NO TOCAR / NO TOCAR / NO TOCAR 
-- ===========================================

table.sort(Shop, function(a, b)
    return a.catname < b.catname
end)

wbymod = {}

for _,v in pairs(Shop) do
    table.sort(v.props, function(a, b)
        return a.m < b.m
    end)

    for _,b in pairs(v.props) do
        if b.w ~= nil then
            wbymod[b.m] = b.w
        end
    end
end

end

