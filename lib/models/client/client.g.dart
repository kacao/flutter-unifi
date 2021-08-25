// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      siteId: json['site_id'] as String?,
      assocTime: json['assoc_time'] as int?,
      latestAssocTime: json['latest_assoc_time'] as int?,
      oui: json['oui'] as String?,
      userId: json['user_id'] as String?,
      id: json['_id'] as String?,
      mac: json['mac'] as String?,
      isGuest: json['is_guest'] as bool?,
      firstSeen: json['first_seen'] as int?,
      lastSeen: json['last_seen'] as int?,
      isWired: json['is_wired'] as bool?,
      hostname: json['hostname'] as String?,
      uptimeByUap: json['_uptime_by_uap'] as int?,
      lastSeenByUap: json['_last_seen_by_uap'] as int?,
      isGuestByUap: json['_is_guest_by_uap'] as bool?,
      apMac: json['ap_mac'] as String?,
      channel: json['channel'] as int?,
      radio: json['radio'] as String?,
      radioName: json['radio_name'] as String?,
      essid: json['essid'] as String?,
      bssid: json['bssid'] as String?,
      powersaveEnabled: json['powersave_enabled'] as bool?,
      is11r: json['is_11r'] as bool?,
      ccq: json['ccq'] as int?,
      rssi: json['rssi'] as int?,
      noise: json['noise'] as int?,
      signal: json['signal'] as int?,
      txRate: json['tx_rate'] as int?,
      rxRate: json['rx_rate'] as int?,
      txPower: json['tx_power'] as int?,
      idletime: json['idletime'] as int?,
      ip: json['ip'] as String?,
      dhcpendTime: json['dhcpend_time'] as int?,
      satisfaction: json['satisfaction'] as int?,
      anomalies: json['anomalies'] as int?,
      vlan: json['vlan'] as int?,
      radioProto: json['radio_proto'] as String?,
      uptime: json['uptime'] as int?,
      txBytes: json['tx_bytes'] as int?,
      rxBytes: json['rx_bytes'] as int?,
      txPackets: json['tx_packets'] as int?,
      txRetries: json['tx_retries'] as int?,
      wifiTxAttempts: json['wifi_tx_attempts'] as int?,
      rxPackets: json['rx_packets'] as int?,
      bytesR: json['bytes-r'] as int?,
      txBytesR: json['tx_bytes-r'] as int?,
      rxBytesR: json['rx_bytes-r'] as int?,
      qosPolicyApplied: json['qos_policy_applied'] as bool?,
      uptimeByUsw: json['_uptime_by_usw'] as int?,
      lastSeenByUsw: json['_last_seen_by_usw'] as int?,
      isGuestByUsw: json['_is_guest_by_usw'] as bool?,
      swMac: json['sw_mac'] as String?,
      swDepth: json['sw_depth'] as int?,
      swPort: json['sw_port'] as int?,
      network: json['network'] as String?,
      networkId: json['network_id'] as String?,
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'site_id': instance.siteId,
      'assoc_time': instance.assocTime,
      'latest_assoc_time': instance.latestAssocTime,
      'oui': instance.oui,
      'user_id': instance.userId,
      '_id': instance.id,
      'mac': instance.mac,
      'is_guest': instance.isGuest,
      'first_seen': instance.firstSeen,
      'last_seen': instance.lastSeen,
      'is_wired': instance.isWired,
      'hostname': instance.hostname,
      '_uptime_by_uap': instance.uptimeByUap,
      '_last_seen_by_uap': instance.lastSeenByUap,
      '_is_guest_by_uap': instance.isGuestByUap,
      'ap_mac': instance.apMac,
      'channel': instance.channel,
      'radio': instance.radio,
      'radio_name': instance.radioName,
      'essid': instance.essid,
      'bssid': instance.bssid,
      'powersave_enabled': instance.powersaveEnabled,
      'is_11r': instance.is11r,
      'ccq': instance.ccq,
      'rssi': instance.rssi,
      'noise': instance.noise,
      'signal': instance.signal,
      'tx_rate': instance.txRate,
      'rx_rate': instance.rxRate,
      'tx_power': instance.txPower,
      'idletime': instance.idletime,
      'ip': instance.ip,
      'dhcpend_time': instance.dhcpendTime,
      'satisfaction': instance.satisfaction,
      'anomalies': instance.anomalies,
      'vlan': instance.vlan,
      'radio_proto': instance.radioProto,
      'uptime': instance.uptime,
      'tx_bytes': instance.txBytes,
      'rx_bytes': instance.rxBytes,
      'tx_packets': instance.txPackets,
      'tx_retries': instance.txRetries,
      'wifi_tx_attempts': instance.wifiTxAttempts,
      'rx_packets': instance.rxPackets,
      'bytes-r': instance.bytesR,
      'tx_bytes-r': instance.txBytesR,
      'rx_bytes-r': instance.rxBytesR,
      'qos_policy_applied': instance.qosPolicyApplied,
      '_uptime_by_usw': instance.uptimeByUsw,
      '_last_seen_by_usw': instance.lastSeenByUsw,
      '_is_guest_by_usw': instance.isGuestByUsw,
      'sw_mac': instance.swMac,
      'sw_depth': instance.swDepth,
      'sw_port': instance.swPort,
      'network': instance.network,
      'network_id': instance.networkId,
    };
