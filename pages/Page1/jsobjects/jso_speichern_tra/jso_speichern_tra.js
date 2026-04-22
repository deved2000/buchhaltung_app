export default {
    speichern: async () => {
        try {
            if (Table_tra.selectedRow?.sid != null && Table_tra.selectedRow?.sid !== "") {
                await update_rs_transaktion.run();
                await insertTransaktion.run();
                await monatsliste_tra.run();
                await konto_saldo_ende.run();
                resetWidget('InputBeschreibung_tra');
                resetWidget('InputBetrag_tra');
                resetWidget('Select_vonKonto');
                resetWidget('Select_zuKonto');
                resetWidget('Select_Schuldner');
                resetWidget('DatePicker_tra');
                showAlert('Transaktion aktualisiert ✅', 'success');
                removeValue("");
            } else {
                await insertTransaktion.run();
                await monatsliste_tra.run();
                await konto_saldo_ende.run();
                resetWidget('InputBeschreibung_tra');
                resetWidget('InputBetrag_tra');
                resetWidget('Select_vonKonto');
                resetWidget('Select_zuKonto');
                resetWidget('Select_Schuldner');
                resetWidget('DatePicker_tra');
                showAlert('Transaktion gespeichert ✅', 'success');
                removeValue("");
            }
        } catch (e) {
            showAlert('Fehler beim Speichern ❌', 'error');
        }
    }
}