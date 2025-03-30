using UnityEngine;

[CreateAssetMenu(fileName = "NewShaderMaterial", menuName = "Shader Demo/Shader Material Data")]
public class ShaderMaterialData : ScriptableObject
{
    public Material material;
    public string materialName;
    [TextArea(2, 5)]
    public string materialDescription;
}
